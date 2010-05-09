
Definitions.


Rules.


&&     : {token, {andand, TokenLine}}.
char   : {token, {char, TokenLine}}.
,      : {token, {comma, TokenLine}}.
%/      : {token, {div, TokenLine}}.
else   : {token, {else, TokenLine}}.
=      : {token, {eq, TokenLine}}.
==     : {token, {eqeq, TokenLine}}.
>=     : {token, {gteq, TokenLine}}.
>      : {token, {gt, TokenLine}}.
void   : {token, {void, TokenLine}}.
%if     : {token, {if, TokenLine}}.
int    : {token, {int, TokenLine}}.
[0-9]+ : {token, {int_constant, TokenLine, list_to_integer(TokenChars)}}.
\{     : {token, {lbrace, TokenLine}}.
\}     : {token, {rbrace, TokenLine}}.
\[     : {token, {lbrack, TokenLine}}.
\]     : {token, {rbrack, TokenLine}}.
\(     : {token, {lparen, TokenLine}}.
\)     : {token, {rparen, TokenLine}}.
<      : {token, {lt, TokenLine}}.
<==    : {token, {lteq, TokenLine}}.
\-     : {token, {minus, TokenLine}}.
\*     : {token, {mul, TokenLine}}.
%!     : {token, {not, TokenLine}}.
%!=     : {token, {noteq, TokenLine}}.
||     : {token, {oror, TokenLine}}.
\+     : {token, {plus, TokenLine}}.
return : {token, {return, TokenLine}}.
;      : {token, {semi, TokenLine}}.
while  : {token, {while, TokenLine}}.
\n     : skip_token.
//.*\n : skip_token.
(_|[a-zA-Z])(_|[a-zA-Z]|[0-9])* : {token, {ident, TokenLine, list_to_atom(TokenChars)}}.
\s     : skip_token.
.      : {error, unknown_symbol}.

Erlang code.

