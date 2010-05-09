Nonterminals identifier expression.

Terminals 'ident' 'int_constant' 'lparen' 'rparen'.

Rootsymbol expression.


identifier -> 'ident' : '$1'.


expression -> identifier : ['$1'].

expression -> 'int_constant' : '$1'.

expression -> 'lparen' expression 'rparen' : ['$1'].



Erlang code.



