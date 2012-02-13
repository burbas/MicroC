Nonterminals  expression binary_operator statement simple_compound_statement statement_list declaration declaration_list base_type declarator program toplevel_declaration_list toplevel_declaration function_parameters formals_list formal expression_list.

Terminals 'andand' 'char' 'comma' 'div' 'else' 'eq' 'eqeq' 'gteq' 'gt' 'void' 'if' 'int' 'int_constant' '{' '}' '[' ']' '(' ')' 'lt' 'lteq' 'minus' 'mul' 'not' 'noteq' 'oror' 'plus' 'return' 'semi' 'while' 'ident'.

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

expression ->
    'ident' : '$1'.
expression -> 
    'int_constant' : '$1'.
expression ->
    '(' expression ')' : '$2'.
expression ->
    'ident' '[' expression ']' : array('$1', '$3', line('$1')).
expression ->
    'ident' '(' ')' : function_call('$1', nil, line('$1')).
expression ->
    'ident' '(' expression_list ')' : function_call('$1', '$3', line('$1')).
expression ->
    expression binary_operator expression : binary_op('$2', '$1','$3', line('$2')).
expression ->
    expression 'eq' expression : assign('$1', '$3', line('$2')).
expression ->
    'minus' expression : unary('minus', '$2', line('$1')).
expression ->
    'not' expression : unary('not', '$2', line('$1')).
expression ->
    expression 'andand' expression : binary_op('andand', '$1', '$3', line('$2')).
expression ->
    expression 'oror' expression : binary_op('oror', '$1', '$3', line('$2')).

expression_list ->
    expression : ['$1'].
expression_list ->
    expression_list 'comma' expression : '$1'++['$3'].

 
binary_operator ->
    'lt' : 'lt'.
binary_operator ->
    'gt' : 'gt'.
binary_operator ->
    'lteq' : 'lteq'.
binary_operator ->
    'gteq' : 'gteq'.
binary_operator ->
    'noteq' : 'noteq'.
binary_operator ->
    'eqeq' : 'eqeq'.
binary_operator ->
    'minus' : 'minus'.
binary_operator ->
    'mul' : 'mul'.
binary_operator ->
    'plus' : 'plus'.
binary_operator ->
    'div' : 'div'.


statement ->				 
    simple_compound_statement : '$1'.
statement ->
    expression 'semi' : effect('$1').
statement ->
    'semi' : statement(nil).
statement ->
    'if' '(' expression ')' statement : if_expr('$3', '$5', nil, line('$1')). 
statement ->
    'if' '(' expression ')' statement 'else' statement : if_expr('$3', '$5', '$7', line('$1')).
statement ->
    'while' '(' expression ')' statement : while('$3', '$5', line('$1')).
statement ->			
    'return' expression 'semi' : return('$2', line('$1')).
statement ->
    'return' 'semi' : return({void, 0}, line('$1')).

simple_compound_statement ->
    '{' statement_list '}' : '$2'.

statement_list ->
    '$empty' : [void].
statement_list ->
    statement : ['$1'].
statement_list ->
    statement_list statement : '$1' ++ ['$2'].


declaration ->
    base_type 'ident' 'semi' : vardec('$1', '$2', line('$1')).
declaration ->
    base_type 'ident' '[' 'int_constant' ']' 'semi' : arrdec('$1', '$2', '$4', line('$1')).
declaration ->
    base_type 'ident' '[' ']' 'semi' : arrdec('$1', '$2', nil, line('$1')).

declaration_list ->
    declaration : ['$1'].
declaration_list ->
    declaration_list declaration : '$1' ++ ['$2'].

base_type ->
    'char' : '$1'.
base_type ->
    'int' : '$1'.
base_type ->
    'void' : '$1'.

declarator ->
    'ident' : '$1'.
declarator ->
    'ident' '[' 'int_constant' ']' : arrdec(nil, '$1', '$3', line('$1')).
declarator ->
    'ident' '[' ']' : arrdec(nil, '$1', nil, line('$1')).
    


program ->
    toplevel_declaration_list : program('$1', dummy).

toplevel_declaration_list ->    
    toplevel_declaration : ['$1'].
toplevel_declaration_list ->
    toplevel_declaration_list toplevel_declaration : '$1'++['$2'].


toplevel_declaration ->
    base_type 'ident' function_parameters '{' statement_list '}' : function('$2', '$3', '$1', '$5', nil, line('$1')).
toplevel_declaration ->
    base_type 'ident' function_parameters '{' declaration_list statement_list '}' : function('$2', '$3', '$1', '$6', '$5', line('$1')).
toplevel_declaration ->
    base_type 'ident' function_parameters 'semi' : ext_function('$2', '$3', '$1', line('$1')).
toplevel_declaration ->
    declaration : global('$1').

function_parameters ->
    '(' 'void' ')' : nil.
%%function_parameters ->
%%    '(' ')' : nil.
function_parameters ->
    '(' formals_list ')' : '$2'.

formals_list ->
    formal : ['$1'].
formals_list ->
    formals_list 'comma' formal : '$1'++['$3'].

formal ->
    base_type declarator : vardec('$1', '$2', line('$1')).

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

global(Declaration) ->
    #'GLOBAL'{
	declaration = Declaration
       }.

ext_function(Name, Formals, ReturnType, Line) ->
    #'EXTFUNC'{
	      name = Name,
	      formals = Formals,
	      return_type = ReturnType,
	      line = Line
	     }.

function(Name, Formals, ReturnType, Body, Locals, Line) ->
    #'FUNCTION'{
	  name = Name,
	  formals = Formals,
	  return_type = ReturnType,
	  locals = Locals,
	  body = Body,
	  line = Line
	 }.
	  

program(Decs, Source) ->
    #'PROGRAM'{
	 decs = Decs,
	 source = Source
	}.

arrdec(BaseType, Identifier, Size, Line) ->
    #'ARRDEC'{
	base_type = BaseType,
	identifier = Identifier,
	size = Size,
	line = Line
       }.

vardec(BaseType, Declarator, Line) ->
    #'VARDEC'{
	base_type = BaseType,
	declarator = Declarator,
	line = Line
       }.

statement(Value) ->
    #'STATEMENT'{
	   value = Value
	  }.

return(Expression, Line) ->
    statement(#'RETURN'{
		 expression = Expression,
		 line = Line
		}).

while(Expression, Statement, Line) ->
    statement(#'WHILE'{
		 expression = Expression,
		 statement = Statement,
		 line = Line
		}).

if_expr(Expression, Statement1, Statement2, Line) ->
    statement(#'IF'{
		 expression = Expression,
		 statement1 = Statement1,
		 statement2 = Statement2,
		 line = Line
		}).


effect(Expression) ->
    statement(#'EFFECT'{
		 value = Expression
		}).

unary(Operation, Expression, Line) ->
    #'EXPRESSION'{
       value = #'UNARY'{
	 operation = Operation,
	 expression = Expression
	},
       line = Line
      }.

assign(Expr1, Expr2, Line) ->
    #'EXPRESSION'{
	value = #'ASSIGN'{
	  expr1 = Expr1,
	  expr2 = Expr2
	 },
	line = Line
       }.

binary_op(BinOp, Expr1, Expr2, Line) ->
    #'EXPRESSION'{
	   value = #'BINARY_OP'{
	     operation = BinOp,
	     expression1 = Expr1,
	     expression2 = Expr2
	    },
	   line = Line
	  }.

function_call(Ident, FunctionList, Line) ->
    #'EXPRESSION'{
	       value = #'FUNCTION_CALL'{
		 identifier = Ident,
		 argument_list = FunctionList
		},
	       line = Line
	      }.
		   
array(Ident, Expression, Line) ->
    #'EXPRESSION'{
       value = #'ARRAY'{
	 identifier = Ident,
	 expression = Expression
	},
       line = Line
      }.
