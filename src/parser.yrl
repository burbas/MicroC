Nonterminals  expression binary_operator assignment_expression argument_expression_list statement simple_compound_statement compound_statement statement_list declaration declaration_list_opt declaration_list base_type declarator program toplevel_declaration_list toplevel_declaration function_parameters formals_list formal expression_list.

Terminals 'andand' 'char' 'comma' 'div' 'else' 'eq' 'eqeq' 'gteq' 'gt' 'void' 'if' 'int' 'int_constant' 'lbrace' 'rbrace' 'lbrack' 'rbrack' 'lparen' 'rparen' 'lt' 'lteq' 'minus' 'mul' 'not' 'noteq' 'oror' 'plus' 'return' 'semi' 'while' 'ident'.

Rootsymbol program.

Right 100 'eq'.
Left  200 'oror'.
Left  300 'andand'.
Left  400 'eqeq' 'noteq'.
Left  500 'lt' 'gt' 'lteq' 'gteq'.
Left  600 'plus' 'minus'.
Left  700 'mul' 'div'.

Nonassoc 800 'not'.
Nonassoc 900 'ident'.

identifier ->
    'ident' : '$1'.

expression ->
    identifier : '$1'.
expression -> 
    'int_constant' : '$1'.
expression ->
    'lparen' expression 'rparen' : '$2'.
expression ->
    identifier 'lbrack' expression 'rbrack' : array('$1', '$3').
expression ->
    identifier 'lparen' argument_expression_list_opt 'rparen' : function_call('$1', '$3').
expression ->
    expression binary_operator expression : binary_op('$1', '$2','$3').
expression ->
    expression 'minus' expression : binary_op('$2', '$1', '$3').
expression ->
    expression 'mul' expression : binary_op('$2', '$1', '$3').
expression ->
    expression 'plus' expression: binary_op('$2', '$1', '$3').
expression ->
    expression 'div' expression : binary_op('$2', '$1', '$3').
expression ->
    expression 'eq' expression : assign('$1', '$3').
expression ->
    'minus' expression : unary('minus', '$2').
expression ->
    'not' expression : unary('not', '$2').
expression ->
    expression 'andand' expression : binary_op('andand', '$1', '$3').
expression ->
    expression 'oror' expression : binary_op('oror', '$1', '$3').


binary_operator ->
    'lt' : '$1'.
binary_operator ->
    'gt' : '$1'.
binary_operator ->
    'lteq' : '$1'.
binary_operator ->
    'gteq' : '$1'.
binary_operator ->
    'noteq' : '$1'.
binary_operator ->
    'eqeq' : '$1'.

assignment_expression ->
    expression : '$1'.
assignment_expression ->
    'ident' 'eq' expression : ass_exp('$1', '$2').


argument_expression_list ->
    assignment_expression : '$1'.
argument_expression_list ->
    argument_expression_list assignment_expression : ['$1', '$2'].
argument_expression_list ->
    argument_expression_list 'comma' assignment_expression : ['$1', '$3'].


statement ->				 
    simple_compound_statement : '$1'.
statement ->
    expression 'semi' : effect('$1').
statement ->
    'semi' : statement(nil).
statement ->
    'if' 'lparen' expression 'rparen' statement : if_expr('$3', '$5', nil). 
statement ->    
    'if' 'lparen' expression 'rparen' statement 'else' statement : if_expr('$3', '$5', '$7').
statement ->
    'while' 'lparen' expression 'rparen' statement : while('$3', '$5').
statement ->			
    'return' expression 'semi' : return('$2').
statement ->
    'return' 'semi' : return(nil).

simple_compound_statement ->
    'lbrace' statement_list 'rbrace' : '$2'.

compound_statement ->
    'lbrace' declaration_list_opt statement_list 'rbrace' : ['$2','$3'].

%%% MATCH AGAINST EMPTY
statement_list ->
    '$empty' : nil.
statement_list ->
    statement : ['$1'].
statement_list ->
    statement_list statement : '$1' ++ ['$2'].


declaration ->
    base_type declarator 'semi' : vardec('$1', '$2').

declaration_list_opt ->
    '$empty': nil.
declaration_list_opt ->
    declaration_list : ['$1'].

declaration_list ->
    declaration : '$1'.

declaration_list ->
    declaration_list declaration : ['$1', '$2'].

base_type ->
    'char' : '$1'.
base_type ->
    'int' : '$1'.
base_type ->
    'void' : '$1'.

declarator ->
    identifier : '$1'.
declarator ->
    identifier 'lbrack' 'int_constant' 'rbrack' : arrdec('$1', '$3').


program ->
    toplevel_declaration_list : program('$1', dummy).

toplevel_declaration_list ->    
    toplevel_declaration : ['$1'].
toplevel_declaration_list ->
    toplevel_declaration_list toplevel_declaration : '$1'++['$2'].

toplevel_declaration ->
    base_type identifier function_parameters compound_statement : function('$2', '$3', '$1', '$4').
toplevel_declaration ->
    base_type identifier function_parameters 'semi' : ext_function('$2', '$3', '$1').
toplevel_declaration ->
    declaration : global('$1').

function_parameters ->
    'lparen' 'void' 'rparen' : nil.
function_parameters ->
    'lparen' 'rparen' : nil.
function_parameters ->
    'lparen' formals_list 'rparen' : [formals_list].

formals_list ->
    formal : '$1'.
formals_list ->
    formals_list 'comma' formal : ['$1', '$3'].

formal ->
    base_type declarator : vardec('$1', '$2').


Erlang code.

-include("../include/types.hrl").
-export([]).

line({_, Line}) ->
    Line;
line({_, Line, _}) ->
    Line;
line({_, Line, _, _}) ->
    Line;
line(_) ->
    0.

get_value({_,_,P}) ->
    P;
get_value({_,_,_,P}) ->
    P.

ass_exp(Identifier, Expression) ->
    #'EXPRESSION'{
	 value = #'ASSIGN'{
	   expr1 = #'EXPRESSION'{
	     value = {'VAR', Identifier}
	    },
	   expr2 = Expression
	  }
	}.

global(Declaration) ->
    #'GLOBAL'{
	declaration = Declaration
       }.

ext_function(Name, Formals, ReturnType) ->
    #'EXTFUNC'{
	      name = Name,
	      formals = Formals,
	      return_type = ReturnType
	     }.

function(Name, Formals, ReturnType, [Locals|Body]) ->
    #'FUNCTION'{
	  name = Name,
	  formals = Formals,
	  return_type = ReturnType,
	  locals = Locals, 
	  body = Body
	 }.
	  

program(Decs, Source) ->
    #'PROGRAM'{
	 decs = Decs,
	 source = Source
	}.

arrdec(Identifier, Size) ->
    #'ARRDEC'{
	identifier = Identifier,
	size = Size
       }.

vardec(BaseType, Declarator) ->
    #'VARDEC'{
	base_type = BaseType,
	declarator = Declarator
       }.

statement(Value) ->
    #'STATEMENT'{
	   value = Value
	  }.

return(Expression) ->
    statement(#'RETURN'{
		 expression = Expression
		}).

while(Expression, Statement) ->
    statement(#'WHILE'{
		 expression = Expression,
		 statement = Statement
		}).

if_expr(Expression, Statement1, Statement2) ->
    statement(#'IF'{
		 expression = Expression,
		 statement1 = Statement1,
		 statement2 = Statement2
		}).


effect(Expression) ->
    statement(#'EFFECT'{
		 value = Expression
		}).

unary(Operation, Expression) ->
    #'EXPRESSION'{
       value = #'UNARY'{
	 operation = Operation,
	 expression = Expression
	},
       line = 0
      }.

assign(Expr1, Expr2) ->
    #'EXPRESSION'{
	value = #'ASSIGN'{
	  expr1 = Expr1, 
	  expr2 = Expr2
	 },
	line = 0
       }.

binary_op(BinOp, Expr1, Expr2) ->
    io:format("~p: ~p - ~p~n", [BinOp, Expr1, Expr2]),
    #'EXPRESSION'{
	   value = #'BINARY_OP'{
	     operation = BinOp,
	     expression1 = Expr1,
	     expression2 = Expr2
	    },
	   line = line(BinOp)
	  }.

function_call({IdentLine, _IdentLength, IdentValue}, FunctionList) ->
    #'EXPRESSION'{
	       value = #'FUNCTION_CALL'{
		 identifier = IdentValue,
		 argument_list = [FunctionList]
		},
	       line = IdentLine
	      }.
		   
array({IdentLine, _IdentLength, IdentValue}, Expression) ->
    #'EXPRESSION'{
       value = #'ARRAY'{
	 identifier = IdentValue,
	 expression = Expression
	},
       line = IdentLine
      }.
