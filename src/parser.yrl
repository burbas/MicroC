Nonterminals identifier expression.

Terminals 'andand' 'char' 'charconst' 'comma' 'div' 'else' 'eqeq' 'gteq' 'gt' 'void' 'if' 'int' 'int_constant' 'lbrace' 'rbrace' 'lbrack' 'rbrack' 'lparen' 'rparen' 'lt' 'lteq' 'minus' 'mul' 'not' 'noteq' 'oror' 'plus' 'return' 'semi' 'while' 'ident'.

Rootsymbol expression.

%% Expressions
   expression -> 'char' : '$1'.
   

%% Statements
   statements -> statements statement 'semi'.
   statements -> statement 'semi'.

   statement -> matched.
   statement -> unmatched.

   matched -> 'if' 'lparen' expression 'rparen' 'then' 

Erlang code.



