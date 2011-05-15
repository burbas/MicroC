
Definitions.
Comment = ((/\*([^*]|\*)*\*/)|(//.*\n))
HiddenChars = ((\n)|(\r)|(\t)|(\s)|(\f))
Identifier = (_|[a-zA-Z])(_|[a-zA-Z]|[0-9])*

Rules.


&&             : {token, {'andand', TokenLine}}.
char           : {token, {'char', TokenLine}}.
,              : {token, {'comma', TokenLine}}.
/              : {token, {'div', TokenLine}}.
else           : {token, {'else', TokenLine}}.
=              : {token, {'eq', TokenLine}}.
==             : {token, {'eqeq', TokenLine}}.
>=             : {token, {'gteq', TokenLine}}.
>              : {token, {'gt', TokenLine}}.
void           : {token, {'void', TokenLine}}.
if             : {token, {'if', TokenLine}}.
int            : {token, {'int', TokenLine}}.
[0-9]+         : {token, {'int_constant', TokenLine, list_to_integer(TokenChars)}}.
\{             : {token, {'lbrace', TokenLine}}.
\}             : {token, {'rbrace', TokenLine}}.
\[             : {token, {'lbrack', TokenLine}}.
\]             : {token, {'rbrack', TokenLine}}.
\(             : {token, {'lparen', TokenLine}}.
\)             : {token, {'rparen', TokenLine}}.
<              : {token, {'lt', TokenLine}}.
<=             : {token, {'lteq', TokenLine}}.
\-             : {token, {'minus', TokenLine}}.
\*             : {token, {'mul', TokenLine}}.
!              : {token, {'not', TokenLine}}.
!=             : {token, {'noteq', TokenLine}}.
\|\|           : {token, {'oror', TokenLine}}.
\+             : {token, {'plus', TokenLine}}.
return         : {token, {'return', TokenLine}}.
;              : {token, {'semi', TokenLine}}.
while          : {token, {'while', TokenLine}}.
{Comment}      : skip_token.
{Identifier}   : {token, {'ident', TokenLine, TokenLen, list_to_atom(TokenChars)}}.
{HiddenChars}+ : skip_token.
.              : {error, unknown_symbol}.

Erlang code.
strip(TokenChars, TokenLen) ->
    erlang:list_to_atom(lists:sublist(TokenChars, 2, TokenLen - 2)).