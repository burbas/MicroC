%%%-------------------------------------------------------------------
%%% @author Daniel Widgren <daniel@minidaniel>
%%% @copyright (C) 2011, Daniel Widgren
%%% @doc
%%%
%%% @end
%%% Created : 23 Jun 2011 by Daniel Widgren<daniel@minidaniel>
%%%-------------------------------------------------------------------
-module(semantic_test).

-include_lib("eunit/include/eunit.hrl").

-define(CPATH, "../test/cfiles/incorrect/semantic/").

semantic_test_() ->
    {setup,
     fun setup/0,
     fun cleanup/1,
     ?_test(
	begin
	    se01(),
	    se02(),
	    se03(),
	    se04(),
	    se05(),
	    se06()
	end)}.

setup() ->
    microc:start_link().

cleanup(_) ->
    ok.

se01() ->
    ?assertEqual({error, not_found, b}, catch(microc:compile(?CPATH++"se01.c"))).

se02() ->
    ?assertEqual({error,not_found,foo}, catch(microc:compile(?CPATH++"se02.c"))).

se03() ->
    ?assertEqual({error,not_found,output}, catch(microc:compile(?CPATH++"se03.c"))).

se04() ->
    ?assertEqual({error,already_declared}, catch(microc:compile(?CPATH++"se04.c"))).

se05() ->
    ?assertEqual({error,already_declared}, catch(microc:compile(?CPATH++"se05.c"))).

se06() ->
    ?assertEqual({error,already_declared}, catch(microc:compile(?CPATH++"se06.c"))).





