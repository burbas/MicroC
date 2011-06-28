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

incorrect_semantic_test_() ->
    {foreach,
     fun setup/0,
     fun cleanup/1,
     [
      fun se01/0,
      fun se02/0,
      fun se03/0,
      fun se04/0,
      fun se05/0,
      fun se06/0,
      fun se07/0,
      fun se08/0,
      fun se09/0,
      fun se10/0,
      fun se11/0,
      fun se12/0,
      fun se13/0,
      fun se14/0,
      fun se15/0,
      fun se16/0,
      fun se17/0,
      fun se18/0,
      fun se19/0
      %% fun se20/0,
      %% fun se21/0,
      %% fun se22/0,
      %% fun se23/0,
      %% fun se24/0,
      %% fun se25/0,
      %% fun se26/0,
      %% fun se27/0,
      %% fun se28/0,
      %% fun se29/0,
      %% fun se30/0,
      %% fun se31/0,
      %% fun se32/0,
      %% fun se33/0,
      %% fun se34/0
     ]}.

setup() ->
    application:start(microc).

cleanup(_) ->
    application:stop(microc).

se01() ->
    try
	microc:compile(?CPATH++"se01.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, b}, Reason)
    end.

se02() ->
   try
	microc:compile(?CPATH++"se02.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, foo}, Reason)
    end.

se03() ->
    try
	microc:compile(?CPATH++"se03.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, output}, Reason)
    end.

se04() ->
   try
	microc:compile(?CPATH++"se04.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, already_decleared}, Reason)
    end.

se05() ->
    try
	microc:compile(?CPATH++"se05.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, already_decleared}, Reason)
    end.

se06() ->
   try
	microc:compile(?CPATH++"se06.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, already_decleared}, Reason)
    end.

se07() ->
    try
	microc:compile(?CPATH++"se07.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, return_missmatch}, Reason)
    end.

se08() ->
   try
	microc:compile(?CPATH++"se08.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, return_missmatch}, Reason)
    end.

se09() ->
    try
	microc:compile(?CPATH++"se09.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, return_missmatch}, Reason)
    end.

se10() ->
   try
	microc:compile(?CPATH++"se10.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, n}, Reason)
    end.

se11() ->
    try
	microc:compile(?CPATH++"se11.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, incompatible_types}, Reason)
    end.

se12() ->
   try
	microc:compile(?CPATH++"se12.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, a}, Reason)
    end.

se13() ->
    try
	microc:compile(?CPATH++"se13.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, unmatched_types}, Reason)
    end.

se14() ->
   try
	microc:compile(?CPATH++"se14.c")
   catch
       _:Value ->
	   {{{_, Reason}, _}, _} = Value,
	   ?assertMatch({error, not_found, f}, Reason)
   end.

se15() ->
    try
	microc:compile(?CPATH++"se15.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_same_type}, Reason)
    end.

se16() ->
   try
	microc:compile(?CPATH++"se16.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_same_type}, Reason)
    end.

se17() ->
    try
	microc:compile(?CPATH++"se17.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, illegal_pointer}, Reason)
    end.

se18() ->
   try
	microc:compile(?CPATH++"se18.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, illegal_pointer}, Reason)
    end.

se19() ->
    try
	microc:compile(?CPATH++"se19.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, illegal_pointer}, Reason)
    end.

%% se20() ->
%%    try
%% 	microc:compile(?CPATH++"se20.c")
%%     catch
%% 	_:Value ->
%% 	    {{{_, Reason}, _}, _} = Value,
%% 		?assertMatch({error, not_found, foo}, Reason)
%%     end.

%% se21() ->
%%     try
%% 	microc:compile(?CPATH++"se21.c")
%%     catch
%% 	_:Value ->
%% 	    {{{_, Reason}, _}, _} = Value,
%% 		?assertMatch({error, not_found, b}, Reason)
%%     end.

%% se22() ->
%%    try
%% 	microc:compile(?CPATH++"se22.c")
%%     catch
%% 	_:Value ->
%% 	    {{{_, Reason}, _}, _} = Value,
%% 		?assertMatch({error, not_found, foo}, Reason)
%%     end.

%% se23() ->
%%     try
%% 	microc:compile(?CPATH++"se23.c")
%%     catch
%% 	_:Value ->
%% 	    {{{_, Reason}, _}, _} = Value,
%% 		?assertMatch({error, not_found, b}, Reason)
%%     end.

%% se24() ->
%%    try
%% 	microc:compile(?CPATH++"se24.c")
%%     catch
%% 	_:Value ->
%% 	    {{{_, Reason}, _}, _} = Value,
%% 		?assertMatch({error, not_found, foo}, Reason)
%%     end.

%% se25() ->
%%     try
%% 	microc:compile(?CPATH++"se25.c")
%%     catch
%% 	_:Value ->
%% 	    {{{_, Reason}, _}, _} = Value,
%% 		?assertMatch({error, not_found, b}, Reason)
%%     end.

%% se26() ->
%%    try
%% 	microc:compile(?CPATH++"se26.c")
%%     catch
%% 	_:Value ->
%% 	    {{{_, Reason}, _}, _} = Value,
%% 		?assertMatch({error, not_found, foo}, Reason)
%%     end.

%% se27() ->
%%     try
%% 	microc:compile(?CPATH++"se27.c")
%%     catch
%% 	_:Value ->
%% 	    {{{_, Reason}, _}, _} = Value,
%% 		?assertMatch({error, not_found, b}, Reason)
%%     end.

%% se28() ->
%%    try
%% 	microc:compile(?CPATH++"se28.c")
%%     catch
%% 	_:Value ->
%% 	    {{{_, Reason}, _}, _} = Value,
%% 		?assertMatch({error, not_found, foo}, Reason)
%%     end.

%% se29() ->
%%     try
%% 	microc:compile(?CPATH++"se29.c")
%%     catch
%% 	_:Value ->
%% 	    {{{_, Reason}, _}, _} = Value,
%% 		?assertMatch({error, not_found, b}, Reason)
%%     end.

%% se30() ->
%%    try
%% 	microc:compile(?CPATH++"se30.c")
%%     catch
%% 	_:Value ->
%% 	    {{{_, Reason}, _}, _} = Value,
%% 		?assertMatch({error, not_found, foo}, Reason)
%%     end.

%% se31() ->
%%     try
%% 	microc:compile(?CPATH++"se31.c")
%%     catch
%% 	_:Value ->
%% 	    {{{_, Reason}, _}, _} = Value,
%% 		?assertMatch({error, not_found, b}, Reason)
%%     end.

%% se32() ->
%%    try
%% 	microc:compile(?CPATH++"se32.c")
%%     catch
%% 	_:Value ->
%% 	    {{{_, Reason}, _}, _} = Value,
%% 		?assertMatch({error, not_found, foo}, Reason)
%%     end.

%% se33() ->
%%     try
%% 	microc:compile(?CPATH++"se33.c")
%%     catch
%% 	_:Value ->
%% 	    {{{_, Reason}, _}, _} = Value,
%% 		?assertMatch({error, not_found, b}, Reason)
%%     end.

%% se34() ->
%%    try
%% 	microc:compile(?CPATH++"se34.c")
%%     catch
%% 	_:Value ->
%% 	    {{{_, Reason}, _}, _} = Value,
%% 		?assertMatch({error, not_found, foo}, Reason)
%%     end.
