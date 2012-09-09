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
	  return_type = void,
	  kind
         }).

-record(symbol, {
	  name,
	  kind,
	  type,
	  attributes,
	  scope_depth
	 }).

-record(function_type, {
	  arguments,
	  return_type
	 }).


-ifdef(debug).
-define(PRINT_ERROR(MESSAGE, PARAMETERS), io:format("Error: " ++ MESSAGE ++ "~n", PARAMTERES)).
-else.
-define(PRINT_ERROR(T, Y), true).
-endif.

%%% KNOWN PROBLEMS
%%%%%%%%%%%%%%%%%%
% - When an array is returned, only the base type is concidered - not the array itself

insert_symbol(Name, Kind, Type, State) ->
    insert_symbol(Name, Kind, Type, [], State).

insert_symbol(Name, Kind, Type, Attributes, State = #state{symbol_table=ST, depth = Depth}) ->
    case dict:find(Name, ST) of
	{ok, #symbol{scope_depth = Depth}} ->
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
	    NewST = dict:store(Name, #symbol{kind = Kind, type = FType, attributes = Attributes, scope_depth = Depth}, ST),
	    State#state{symbol_table = NewST, type = FType}
    end.

lookup_symbol(Name, #state{symbol_table = ST}) ->
    case dict:find(Name, ST) of
	{ok, #symbol{kind = Kind, type = Type, attributes = Attributes}} ->
	    {ok, Kind, Type, Attributes};
	_ ->
	    error(not_found, "~p is not declared", [Name])
    end.

lookup_symbol(Name, Kind, #state{symbol_table = ST}) ->
    case dict:find(Name, ST) of
	{ok, #symbol{kind = Kind, type = Type, attributes = Attributes}} ->
	    {ok, Type, Attributes};
	_ ->
	    error(not_found, "~p is not declared", [Name])
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
		ArgumentTypes ->
		    {ok, Type, Attributes};
		A = #function_type{arguments = ArgTypes, return_type = ReturnType} ->
		    %% We need to check if the types are compatible (If we are dealing with array we need exact types)
		    [ error(type_mismatch, "", [ArgTypes, ArgumentTypes]) || not compatible_types(ArgTypes, ArgumentTypes) ],
		    {ok, ReturnType, Attributes};
		_ ->
		    error(type_mismatch, "", [Type])
	    end;
	_ ->
	    error(not_found, "~p not declared", [Name])
    end.

get_name({ident, _TokenLine, _TokenLen, Name}) ->
    Name;
get_name(#'ARRDEC'{base_type = _, identifier = Identifier, size = _}) ->
    get_name(Identifier).


type_check([], State) ->
    State;

type_check(P, State) when not is_list(P) ->
    type_check([P], State);

type_check([P|Tl], State) when is_list(P) ->
    NewState = type_check(P, State),
    type_check(Tl, NewState);

type_check([#'EXTFUNC'{name = Name, return_type = ReturnType, formals = Formals}|Tl], State) ->
    case State#state.depth of
        0 ->
	    ArgTypes =
		case Formals of
		    nil ->
			[void];
		    _ ->
			lists:map(
			  fun(X) ->
				  A = (type_check(X, State)),
				  case A#state.kind of
				      dirty_array ->
					  {array, A#state.type};
				      _ ->
					  A#state.type
				  end
			  end,
			  Formals)
		end,
	    RetType = (type_check(ReturnType, State))#state.type,

            NewState = insert_symbol(get_name(Name), func, {ArgTypes, RetType}, extern, State),
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
type_check([#'FUNCTION'{name = Name, formals = Formals, return_type = ReturnType, locals = Locals, body = Body}|Tl], State = #state{depth = Depth}) ->
    io:format("Function:~nName: ~p~nFormals: ~p~nReturn Type: ~p~nLocals: ~p~nBody: ~p~n", [Name, Formals, ReturnType, Locals, Body]),
    ArgTypes =
        case Formals of
            nil ->
                [void];
            _ ->
                lists:map(
                  fun([[void]]) ->
                          nil;
                     (X) ->
                          io:format("FORMAL: ~p~n", [X]),
                          ArgState = (type_check(X, State#state{depth = Depth +1})),
                          case ArgState#state.kind of
                              dirty_array ->
                                  {array, ArgState#state.type};
                              _Kind ->
                                  ArgState#state.type
                          end
                  end,
                  Formals
                 )
        end,
    %% Check the return type
    RetType = (type_check(ReturnType, State))#state.type,

    %% Insert function in the table as (name = Name, type = func, spec = {ArgumentTypes, ReturnType})
    NewState = insert_symbol(get_name(Name), func, {ArgTypes, RetType}, State),


    NewState2 = type_check(Formals, NewState#state{depth = Depth + 1}),
    NewState3 = type_check(Locals, NewState2),
    type_check(Body, NewState3#state{current_function = get_name(Name)}),

    type_check(Tl, NewState);

type_check([#'VARDEC'{base_type = BaseType, declarator = Declarator}|Tl], State) ->
    %% Get the type
    Type = type_check(BaseType, State),

    NewST =
    case Declarator of
	{ident, _TokenLine, _TokenLen, _Name} ->
	    insert_symbol(get_name(Declarator), var, Type#state.type, Type);
	_ ->
	    type_check(Declarator, State#state{type = Type#state.type})
    end,
    %% Make a recursive call on the tail
    type_check(Tl, NewST);

type_check([#'ARRDEC'{identifier = Identifier, base_type = BaseType, size = Size}|Tl], State) ->
    %% Get the type
    Type = case BaseType of
	       nil ->
		   State#state.type;
	       _ ->
		   (type_check(BaseType, State))#state.type
	   end,

    %% Get the name
    Name = get_name(Identifier),

    %% Inserts the symbol
    NewState = insert_symbol(Name, array, Type, Size, State),

    type_check(Tl, NewState#state{kind = dirty_array});

type_check([#'WHILE'{expression = Expression, statement = Statement}|Tl], State) ->
    NewState = type_check(Expression, State),
    type_check(Statement, NewState#state{depth = NewState#state.depth +1}),
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

type_check([#'STATEMENT'{value = SValue}|Tl], State) ->
    type_check(SValue, State#state{depth = State#state.depth + 1}),
    type_check(Tl, State);

type_check([#'EXPRESSION'{value = Value}|Tl], State) ->
    NewState = type_check(Value, State),
    type_check(Tl, NewState);


type_check([#'UNARY'{operation = _Operation, expression = Expression}|Tl], State) ->
    NewState = type_check(Expression, State),
    type_check(Tl, NewState);

type_check([#'BINARY_OP'{operation = _Operation, expression1 = Expr1, expression2 = Expr2}|Tl], State) ->
    TExpr1 = type_check(Expr1, State),
    TExpr2 = type_check(Expr2, TExpr1),

    case  compatible_types(TExpr1#state.type, TExpr2#state.type) of
	true ->
	    case TExpr2#state.kind == dirty_array orelse TExpr1#state.kind == dirty_array of
		true ->
		    error(illegal_pointer, "Pointers not supported by mC", []);
		_ ->
		    type_check(Tl, TExpr2)
	    end;
	_ ->
	    error(unmatched_types, "Unmatched types in function ~p: Expected: ~p got ~p", [TExpr2#state.current_function, TExpr1#state.type, TExpr2#state.type])
    end;

type_check([#'ASSIGN'{expr1 = Expr1, expr2 = Expr2}|Tl], State) ->
    Expr1State = type_check(Expr1, State),
    Expr2State = type_check(Expr2, Expr1State),

    case compatible_types(Expr1State#state.type, Expr2State#state.type) of
	true ->
	    case Expr1State#state.kind == dirty_array orelse Expr2State#state.kind == dirty_array of
		true ->
		    error(illegal_pointer, "Pointers not supported by mC", []);
		_ ->
		    case Expr1State#state.kind of
			var ->
			    type_check(Tl, Expr2State);
			array ->
			    (type_check(Tl, Expr2State))#state{kind = array};
			_ ->
			    error(no_assignment, "Can not assign non-variables", [])
		    end
	    end;
	_ ->
	    error(incompatible_types, "Can not assign ~p a value of ~p",
		  [Expr1State#state.type, Expr2State#state.type])
    end;


type_check([#'ARRAY'{identifier = Identifier, expression = Expr}|Tl], State) ->
    {ok, Type, _} = lookup_symbol(get_name(Identifier), array, State),
    NewState = type_check(Expr, State),

    case NewState#state.type of
	int ->
	    type_check(Tl, State#state{type = Type, kind = array});
	_ ->
	    error(illegal_index, "Can't use datatype ~p as index in array", [NewState#state.type])
    end;

type_check([#'EFFECT'{value = Value}|Tl], State) ->
    NewState = type_check(Value, State),
    type_check(Tl, NewState);

type_check([#'FUNCTION_CALL'{identifier = Identifier, argument_list = ArgumentList}|Tl], State) ->
    IdentName = get_name(Identifier),

    ArgumentTypes =
	case ArgumentList of
	    nil ->
		[void];
	    _ ->
		lists:map(
		  fun(X) ->
			  ArgState = (type_check(X, State#state{kind = undefined})),
			  case ArgState#state.kind of
			      dirty_array ->
				  {array, ArgState#state.type};
			      _Kind ->
				  ArgState#state.type
			  end
		  end,
		  ArgumentList)
	end,

    {ok, ReturnType, _} = lookup_symbol(IdentName, func, ArgumentTypes, State),

    type_check(Tl, State#state{return_type = ReturnType, type = ReturnType});

type_check([#'RETURN'{expression = Expression}|Tl], State = #state{current_function = CFunc}) ->

    ExprState = #state{type = ReturnType, kind = Kind} = type_check(Expression, State),

    {ok, FReturnType, _} = lookup_symbol(CFunc, func, State),

    case valid_return(ExprState, FReturnType#function_type.return_type) of
	true ->
	    type_check(Tl, State);
	_ ->
	    error(return_mismatch, "The function ~p is declared as ~p but returns ~p ~p", [CFunc, FReturnType#function_type.return_type, Kind, ReturnType])
    end;

%% The next four functions is used to match out the innermost values
type_check([{ident, _TokenLine, _TokenLen, Name}], State) ->
    case lookup_symbol(Name, State) of
	{ok, array, Type, _} ->
	    State#state{kind = dirty_array, type = Type};
	{ok, Kind, Type, _} ->
	    State#state{kind = Kind, type = Type}
    end;
type_check([{int_constant, _TokenLine, _Value}], State) ->
    State#state{type = int, kind=const};
type_check([{char, _TokenLine}], State) ->
    State#state{type = char, kind=const};
type_check([{int, _TokenLine}], State) ->
    State#state{type = int, kind=const};
type_check([{void, _TokenLine}], State) ->
    State#state{type = void, kind=const};
type_check([nil|Tl], State) ->
    type_check(Tl, State);

type_check(P, _State) ->
    error(unknown_symbol, "Could not parse ~p", [P]).




analyze(#'PROGRAM'{decs = Decs, source = _Source}) ->
    type_check(Decs, #state{symbol_table = dict:new(), parse_tree = [], depth = 0}).



error(Reason, Message, Parameters) ->
    ?PRINT_ERROR(Message, Parameters),
    error({error, Reason, Parameters}).


valid_return(#state{type = Type, kind = dirty_array}, {array, Type}) ->
    true;
valid_return(#state{type = Type, kind = Kind}, Type) when Kind /= dirty_array ->
    true;
valid_return(#state{type = 'char', kind = Kind}, 'int') when Kind /= dirty_array ->
    true;
valid_return(#state{type = 'int', kind = Kind}, 'char') when Kind /= dirty_array ->
    true;
valid_return(_, _) ->
    false.


compatible_types(A, B) when not is_list(A) ->
    compatible_types([A], B);
compatible_types(A, B) when not is_list(B) ->
    compatible_types(A, [B]);
compatible_types([], []) ->
    true;
compatible_types([], _) ->
    false;
compatible_types(_, []) ->
    false;
compatible_types([Type|Tl1], [Type|Tl2]) ->
    compatible_types(Tl1, Tl2);
compatible_types(['char'|Tl1], ['int'|Tl2]) ->
    compatible_types(Tl1, Tl2);
compatible_types(['int'|Tl1], ['char'|Tl2]) ->
    compatible_types(Tl1, Tl2);
compatible_types(_, _) ->
    false.

