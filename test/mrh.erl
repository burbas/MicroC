-module(mrh).

-export([helper/2, rtl_helper/2, lexer_helper/2, parser_helper/2]).

helper(Path, File) ->
    case catch microc:analyze(Path++File) of
	{'EXIT', Error} ->
	    Error;
	A ->
	    A
    end.

rtl_helper(Path, File) ->
    microc:intermediate(Path++File).

lexer_helper(Path, File) ->
    microc:lex(Path++File).


parser_helper(Path, File) ->
    case catch microc:parse(Path++File) of
	{'EXIT', Error} ->
	    Error;
	A ->
	    A
    end.
