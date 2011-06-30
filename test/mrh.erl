-module(mrh).

-export([helper/2]).

helper(Path, File) ->
    case catch microc:compile(Path++File) of
	{'EXIT', Error} ->
	    Error;
	A ->
	    A
    end.
