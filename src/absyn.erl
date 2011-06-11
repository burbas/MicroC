%%% @author Niclas Axelsson <burbas@Niclas-Axelssons-Mac-mini.local>
%%% @copyright (C) 2011, Niclas Axelsson
%%% @doc
%%%
%%% @end
%%% Created : 15 May 2011 by Niclas Axelsson <burbas@Niclas-Axelssons-Mac-mini.local>

-module(absyn).

-include("../include/types.hrl").


%% API
-export([analyze/1]).

-record(state, {
          symbol_table,
          parse_tree,
          depth = 0,
	  type,
	  current_function,
	  return_type
         }).

-record(symbol, {
	  kind,
	  type,
	  attributes
	 }).

-record(function_type, {
	  arguments,
	  return_type
	 }).


insert_symbol(Name, Kind, Type, State) ->
    insert_symbol(Name, Kind, Type, [], State).

insert_symbol(Name, Kind, Type, Attributes, State = #state{symbol_table=ST}) ->
    case dict:find(Name, ST) of
	{ok, _Value} ->
	    error(already_declared, "~p have already been declared!", [Name]);
	_ ->
	    case Kind of
		func ->
		    {Arguments, ReturnType} = Type,
		    FType = #function_type{
		      arguments = Arguments,
		      return_type = ReturnType
		     };
		_ ->
		    FType = Type
	    end,
	    NewST = dict:store(Name, #symbol{kind = Kind, type = FType, attributes = Attributes}, ST),
	    State#state{symbol_table = NewST, type = FType}
    end.

lookup_symbol(Name, #state{symbol_table = ST}) ->
    case dict:find(Name, ST) of
	{ok, #symbol{kind = Kind, type = Type, attributes = Attributes}} ->
	    {ok, Kind, Type, Attributes};
	_ ->
	    {error, not_found}
    end.

lookup_symbol(Name, Kind, #state{symbol_table = ST}) ->
    case dict:find(Name, ST) of
	{ok, #symbol{kind = Kind, type = Type, attributes = Attributes}} ->
	    {ok, Type, Attributes};
	_ ->
	    {error, not_found}
    end.

lookup_symbol(Name, Kind, Arguments, #state{symbol_table = ST}) ->
    case dict:find(Name, ST) of
	{ok, #symbol{kind = Kind, type = Type, attributes = Attributes}} ->
	    ArgumentTypes = 
		lists:map(
		  fun({ident, _TokenLine, _TokenLen, FName}) ->
			  case dict:find(FName, ST) of
			      {ok, Type} ->
				  Type;
			      _ ->
				  error(use_of_undeclared_variable, "Variable ~p not declared", [FName])
			  end;
		     (P) ->
			  P
		  end, Arguments),
	    case Type of
		#function_type{arguments = ArgumentTypes, return_type = ReturnType} ->
		    {ok, ReturnType, Attributes};
		_ ->
		    case Type == ArgumentTypes of
			true ->
			    {ok, Type, Attributes};
			_ ->
			    {error, not_same_type}
		    end
	    end;
	_ ->
	    {error, not_found}
    end.

get_name({ident, _TokenLine, _TokenLen, Name}) ->
    Name;
get_name(#'ARRDEC'{base_type = _, identifier = Identifier, size = _}) ->
    Identifier.

type_check([], State) ->
    State;

type_check(P, State) when not is_list(P) ->
    type_check([P], State);

type_check([#'EXTFUNC'{name = Name, return_type = ReturnType, formals = Formals}|Tl], State) ->
    case State#state.depth of
        0 ->
	    ArgTypes = lists:map(fun(X) -> type_check(X, State) end, Formals),
	    RetType = type_check(ReturnType, State),

            NewState = insert_symbol(Name, func, {ArgTypes, RetType}, extern, State),
            type_check(Tl, NewState);
        _ ->
            error(not_global_scope, "External function ~p declared in a non-global scope", [Name])
    end;

type_check([#'GLOBAL'{declaration = Declarator}|Tl], State) ->
    case State#state.depth of 
        0 ->
	    NewST = type_check(Declarator, State),
	    type_check(Tl, NewST);
        _ ->
            error(not_global_scope, "Global declaration detected in non-global scope!", [])
    end;

%% Function-type
type_check([#'FUNCTION'{name = Name, formals = Formals, return_type = ReturnType, locals = _Locals, body = Body}|Tl], State) ->
    ArgTypes = case Formals of
		   nil ->
		       [void];
		   _ ->
		       lists:map(
			 fun(X) ->
				 #state{type = Type} = type_check(X, State),
				 Type
			 end,
			 Formals
			)
	       end,
    %% Check the return type
    RetType = (type_check(ReturnType, State))#state.type,
    
    %% Insert function in the table as (name = Name, type = func, spec = {ArgumentTypes, ReturnType})
    NewST = insert_symbol(Name, func, {ArgTypes, RetType}, State),

    NewST2 = type_check(Formals, NewST#state{current_function = Name}),

    %% Increase the scope depth and type-check the body
    Bdy = type_check(Body, NewST2),
    
    case Bdy#state.return_type of
	RetType ->
	    %% Typecheck the rest of the list
	    type_check(Tl, NewST);
	undefined when RetType == void ->
	    type_check(Tl, NewST);
	_ ->
	    error(return_value_invalid, "Function ~p is of type ~p but returns ~p", [Name, RetType, Bdy#state.return_type])
    end;

type_check([#'VARDEC'{base_type = BaseType, declarator = Declarator}|Tl], State) ->
    %% Get the type
    Type = type_check(BaseType, State),
    
    %% Inserts the symbol
    NewST = insert_symbol(get_name(Declarator), var, Type#state.type, State),
   
    %% Make a recursive call on the tail
    type_check(Tl, NewST);

type_check([#'ARRDEC'{identifier = Identifier, base_type = BaseType, size = Size}|Tl], State) ->
    %% Get the type
    Type = type_check(BaseType, State),
    
    %% Get the name
    Name = get_name(Identifier),

    %% Inserts the symbol
    NewState = insert_symbol(Name, array, Type#state.type, Size, State),
    type_check(Tl, NewState);

type_check([#'WHILE'{expression = Expression, statement = Statement}|Tl], State) ->
    NewState = type_check(Expression, State),
    type_check(Statement, NewState),
    type_check(Tl, State);

type_check([#'IF'{expression = Expression, statement1 = Stmt1, statement2 = Stmt2}|Tl], State) ->
    NewState = type_check(Expression, State),
    type_check(Stmt1, NewState),
    case Stmt2 of
      nil ->
	    ok;
	_ ->
	    type_check(Stmt2, NewState)
    end,
    type_check(Tl, State);

type_check([#'STATEMENT'{value = Value}|Tl], State) ->
    type_check(Value, State),
    type_check(Tl, State);

type_check([#'EXPRESSION'{value = Value}|Tl], State) ->
    NewState = type_check(Value, State),
    type_check(Tl, NewState);

%% THIS NEEDS TO BE FIXED
type_check([#'UNARY'{operation = _Operation, expression = Expression}|Tl], State) ->
    type_check(Expression, State),
    type_check(Tl, State);

type_check([#'BINARY_OP'{operation = _Operation, expression1 = Expr1, expression2 = Expr2}|Tl], State) ->
    TExpr1 = type_check(Expr1, State),
    TExpr2 = type_check(Expr2, TExpr1),
    
    case TExpr1#state.type == TExpr2#state.type of
	true ->
	    type_check(Tl, TExpr2);
	_ ->
	    error(unmatched_types, "Unmatched types in binary operation: ~p * ~p", [TExpr1#state.type, TExpr2#state.type])
    end;

type_check([#'ASSIGN'{expr1 = Expr1, expr2 = Expr2}|Tl], State) ->
    NewState = #state{type = TypeExpr1} = type_check(Expr1, State),
    NewState2 = #state{type = TypeExpr2} = type_check(Expr2, NewState),
    
    case TypeExpr1 == TypeExpr2 of
	true ->
	    type_check(Tl, NewState2);
	_ ->
	    error(incompatible_types, "Can not assign ~p a value of ~p", [TypeExpr1, TypeExpr2])
    end;

type_check([#'EFFECT'{value = Value}|Tl], State) ->
    NewState = type_check(Value, State),
    type_check(Tl, NewState);

type_check([#'FUNCTION_CALL'{identifier = Identifier, argument_list = ArgumentList}|Tl], State) ->
    IdentName = get_name(Identifier),
    ArgumentTypes = [ type_check(X, State) || X <- ArgumentList, X /= nil ],
    
    lookup_symbol(IdentName, func, ArgumentTypes, State),
    type_check(Tl, State);

type_check([#'RETURN'{expression = Expression}|Tl], State = #state{current_function = CFunc}) ->

    #state{type = ReturnType} = type_check(Expression, State),

    {ok, FReturnType, _} = lookup_symbol(CFunc, func, State),

    case ReturnType == FReturnType#function_type.return_type of
	true ->
	    type_check(Tl, State#state{return_type = ReturnType});
	_ ->
	    error(return_missmatch, "The function ~p is declared as ~p but returns ~p", [CFunc, FReturnType#function_type.return_type, ReturnType])
    end;

%% The next four functions is used to match out the innermost values
type_check([{ident, _TokenLine, _TokenLen, Name}], State) ->
    case lookup_symbol(Name, State) of
	{ok, _, _, _} ->
	    State#state{type = {ident, Name}};
	{error, _} ->
	    error(not_declared, "Use of undeclared variable ~p", [Name])
    end;		
type_check([{int_constant, _TokenLine, _Value}], State) ->
    State#state{type = int};
type_check([{char, _TokenLine}], State) ->
    State#state{type = char};
type_check([{int, _TokenLine}], State) ->
    State#state{type = int};
type_check([{void, _TokenLine}], State) ->
    State#state{type = void};
type_check([nil|Tl], State) ->
    type_check(Tl, State);

type_check([P|Tl], State) ->
    io:format("LIST: Could not read ~p, continue with the rest of the list~n", [P]),
    type_check(Tl, State);

type_check(P, _State) ->
    io:format("SINGLE ELEMENT: Could not read ~p, continue with the rest of the list~n", [P]).




analyze(#'PROGRAM'{decs = Decs, source = _Source}) ->
    type_check(Decs, #state{symbol_table = dict:new(), parse_tree = [], depth = 0}).



error(Reason, Message, Parameters) ->
    io:format("Error: " ++ Message ++ "~n", Parameters),
    exit(error, Reason).

	    
