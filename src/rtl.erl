%%% @author Niclas Axelsson <burbas@niclas-axelssons-macbook-pro.local>
%%% @copyright (C) 2011, Niclas Axelsson
%%% @doc
%%%
%%% @end
%%% Created :  7 Jul 2011 by Niclas Axelsson <burbas@niclas-axelssons-macbook-pro.local>

-module(rtl).

-include("../include/rtl.hrl").
-include("../include/types.hrl").

-export([ast_to_rtl/1]).

-record(state, {
	  label_counter = 100,
	  temp_counter = 1,
	  previous_temp = [],
	  current_function,
	  ir = [],
	  framesize = 0,
	  symboltable,
	  fp = 1
	 }).



sizeof(?BYTE) -> 1;
sizeof(?LONG) -> 4. %% 32-bits representation

convert_type({int_constant, _, _, _}) -> ?LONG;
convert_type({char, _}) -> ?BYTE;
convert_type({int, _}) -> ?LONG;
convert_type({void, _}) -> ?BYTE. 

clean(State) -> State#state{ir = []}.

unwrap({'int_constant', _TokenLine, Value}) -> Value;
unwrap({'ident', _TokenLine, _TokenLen, Value}) -> Value; 
unwrap({Value, _TokenLine}) -> Value.
 
newLabel(State = #state{label_counter = LabelCounter}) ->
    Label = "L" ++ erlang:integer_to_list(LabelCounter),
    {Label, State#state{label_counter = LabelCounter + 1}}.

newTemp(State = #state{temp_counter = TempCounter}) ->
    Temp = "t" ++ erlang:integer_to_list(TempCounter),
    {Temp, State#state{temp_counter = TempCounter + 1}}.

insert(Name, Temporary, State = #state{symboltable = ST}) ->
    NewST = dict:store(Name, Temporary, ST),
    State#state{symboltable = NewST}.

lookup(Name, State = #state{symboltable = ST}) ->
    case dict:find(Name, ST) of
	{ok, Value} ->
	    Value;
	_ ->
	    {error, not_found}
    end.



flatten([], State) ->
    State;
flatten([#'GLOBAL'{declaration = Declaration}|Tl], State) ->
    IR = 
	case Declaration of
	    #'VARDEC'{base_type = BaseType, declarator = Declarator} ->
		State#state.ir ++ [#'RTL_DATA'{label = unwrap(Declarator), size = sizeof(convert_type(BaseType))}];
	    #'ARRDEC'{identifier = Identifier, base_type = BaseType, size = Size} ->
		State#state.ir ++ [#'RTL_DATA'{label = unwrap(Identifier), size = sizeof(convert_type(BaseType))*unwrap(Size)}]    
	end,
    flatten(Tl, State#state{ir = IR});

%% Local variable declarations
flatten([#'VARDEC'{base_type = BaseType, declarator = Declarator}|Tl], State) ->
    FrameSize = sizeof(convert_type(BaseType)) + State#state.framesize,
    {Temp, NewState} = newTemp(State),
    NewState2 = insert(unwrap(Declarator), Temp, NewState),

    flatten(Tl, NewState2#state{framesize = FrameSize, ir = NewState2#state.ir ++ [Temp]});

%% Local array declarations
flatten([#'ARRDEC'{identifier = Identifier, base_type = BaseType, size = Size}|Tl], State) ->
    FrameSize = (sizeof(convert_type(BaseType))*unwrap(Size)) + State#state.framesize,
    {Temp, NewState} = newTemp(State),
    NewState2 = insert(unwrap(Identifier), Temp, NewState),

    flatten(Tl, NewState2#state{framesize = FrameSize, ir = NewState2#state.ir ++ [Temp]});

flatten([#'FUNCTION_CALL'{identifier = Identifier, argument_list = ArgumentList}|Tl], State) ->
    Name = unwrap(Identifier),
    ArgState = flatten(ArgumentList, clean(State)),

    flatten(Tl, State#state{ir = State#state.ir ++ [#'RTL_CALL'{function = Name, arguments = ArgState#state.ir}]});

flatten([#'STATEMENT'{value = Value}|Tl], State) ->
    NewState = flatten(Value, State),
    flatten(Tl, NewState);

flatten([#'EFFECT'{value = Value}|Tl], State) ->
    NewState = flatten(Value, State),
    flatten(Tl, NewState);

flatten([#'EXPRESSION'{value = Value}|Tl], State) ->
    NewState = flatten(Value, State),
    flatten(Tl, NewState);

flatten([#'BINARY_OP'{operation = OP, expression1 = Expr1, expression2 = Expr2}|Tl], State) ->
    {Temp, NewState} = newTemp(State),
    FExpr1 = flatten(Expr1, NewState),
    FExpr2 = flatten(Expr2, FExpr1),

    IR = State#state.ir ++ FExpr1#state.ir ++ FExpr2#state.ir ++ [#'RTL_BINARY'{binop = OP, dest = Temp, temp1 = FExpr1#state.previous_temp, temp2 = FExpr2#state.previous_temp}],

    flatten(Tl, State#state{ir = IR, previous_temp = Temp});

flatten([#'UNARY'{operation = 'minus', expression = Expr}|Tl], State) ->
    {Temp1, NewState} = newTemp(State),
    {Temp2, NewState2} = newTemp(NewState),

    ExprState = flatten(Expr, NewState2),

    IR = 
	State#state.ir ++ 
	ExprState#state.ir ++ 
	[
	 #'RTL_EVAL'{
	    dest = Temp1,
	    value = #'RTL_ICON'{int = 0}
	   },
	 #'RTL_EVAL'{
		      dest = Temp2,
		      value = #'RTL_SUB'{
			temp1 = Temp1,
			temp2 = ExprState#state.previous_temp
		       }
		    }
	],

    flatten(Tl, ExprState#state{ir = IR, previous_temp = Temp2});

flatten([#'UNARY'{operation = 'not', expression = Expr}|Tl], State) ->
    %% Not yet implemented
    flatten(Tl, State);

flatten([#'ASSIGN'{expr1 = Expr1, expr2 = Expr2}|Tl], State) ->
    {Temp, NewState} = newTemp(State),
    
    FExpr1 = flatten(Expr1, NewState),
    FExpr2 = flatten(Expr2, FExpr1),
    
    IR = State#state.ir ++ FExpr1#state.ir ++ FExpr2#state.ir ++ [#'RTL_ASSIGN'{dest = Temp, temp1 = FExpr1#state.previous_temp, temp2 = FExpr2#state.previous_temp}],
    
    flatten(Tl, State#state{ir = IR, previous_temp = Temp});

flatten([#'IF'{expression = Expr, statement1 = Stmt1, statement2 = Stmt2}|Tl], State) ->
    {ElseLabel, NewState} = newLabel(State),
    {EndLabel, NewState2} = newLabel(NewState),


    #'EXPRESSION'{value = #'BINARY_OP'{operation = OP, expression1 = Expr1, expression2 = Expr2}} = Expr,
    
    Expr1State = flatten(Expr1, NewState),
    Expr2State = flatten(Expr2, Expr1State),
    
    Stmt1State = flatten(Stmt1, Expr2State),
    Stmt2State = flatten(Stmt2, Stmt1State),
    
    IR = 
	State#state.ir ++ 
	Expr1State#state.ir ++ 
	Expr2State#state.ir ++  
	[#'RTL_CJUMP'{
		      relop = unwrap(OP),
		      temp1 = Expr1State#state.previous_temp,
		      temp2 = Expr2State#state.previous_temp,
		      label = ElseLabel
		    },
	 Stmt1#state.ir,
	 #'RTL_JUMP'{
		      label = EndLabel
		    },
	 #'RTL_LABELDEF'{
		      label = ElseLabel
		     }] ++
	Stmt2#state.ir ++
	[#'RTL_LABELDEF'{
	    label = EndLabel
	   }],
    
    flatten(Tl, State#state{ir = IR, previous_temp = []});

flatten([#'WHILE'{expression = Expr, statement = Stmt}|Tl], State) ->
    flatten(Tl, State);

flatten([#'RETURN'{expression = {void, _}}|Tl], State = #state{current_function = CF}) ->
    Endlbl = lookup("__endlbl_" ++ CF, State),
    IR = State#state.ir ++ [#'RTL_JUMP'{label = Endlbl}],

    flatten(Tl, State#state{ir = IR});

flatten([#'RETURN'{expression = Expr}|Tl], State = #state{current_function = CF}) ->
    Endlbl = lookup("__endlbl_" ++ CF, State),
    RetTemp = lookup("__ret_" ++ CF, State),

    ExprState = flatten(Expr, State),
    
    IR = 
	State#state.ir ++
	ExprState#state.ir ++
	[
	 #'RTL_EVAL'{
	    dest = RetTemp,
	    value = ExprState#state.previous_temp
	   },
	 #'RTL_JUMP'{
		      label = Endlbl
		    }
	],
	    
    flatten(Tl, ExprState#state{ir = IR, previous_temp = []});

flatten([#'EXTFUNC'{name = Name, return_type = ReturnType, formals = Formals}|Tl], State) ->
    FName = unwrap(Name),
    Size = sizeof(convert_type(ReturnType)),
    
    flatten(Tl, State);

flatten([#'FUNCTION'{name = Name, formals = Formals, return_type = ReturnType, locals = Locals, body = Body}|Tl], State) ->
    {ReturnTemp, NewState} = newTemp(clean(State)),
    NewState2 = insert("__ret_" ++ unwrap(Name), ReturnTemp, NewState),

    {Endlbl, NewState3} = newLabel(clean(NewState2)),
    NewState4 = insert("__endlbl_" ++ unwrap(Name), Endlbl, NewState2),

    FormalState = flatten(Formals, NewState4),
    LocalState = flatten(Locals, clean(FormalState)),

    BodyState = flatten(Body, LocalState#state{current_function = unwrap(Name)}),

    IR = State#state.ir ++ 
	[#'RTL_PROC'{label = unwrap(Name), 
		     framesize = FormalState#state.framesize + LocalState#state.framesize, 
		     formals = FormalState#state.ir, 
		     locals = LocalState#state.ir, 
		     insns = BodyState#state.ir ++ [#'RTL_LABELDEF'{label = Endlbl}]
		    }
	],
    flatten(Tl, BodyState#state{ir = IR, current_function = []});

flatten([{int_constant, _TokenLine, Value}], State) ->
    State#state{previous_temp = #'RTL_ICON'{int = Value}, ir = []};

flatten([{ident, _TokenLine, _TokenLen, Value}], State) ->
    Temp = lookup(Value, State),
    State#state{previous_temp = Temp, ir = []};

flatten([H|T], State) ->
    flatten(T, State);
flatten(P, State) when not is_list(P) ->
    flatten([P], State).
    

ast_to_rtl(#'PROGRAM'{decs = Decs, source = _Source}) ->
    (flatten(Decs, #state{symboltable = dict:new()}))#state.ir.
