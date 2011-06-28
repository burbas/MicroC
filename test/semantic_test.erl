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

-include("path.hrl").

incorrect_semantic_test_() ->
    {foreach,
     fun setup/0,
     fun cleanup/1,
     [
      fun ise:ise01/0,
      fun ise:ise02/0,
      fun ise:ise03/0,
      fun ise:ise04/0,
      fun ise:ise05/0,
      fun ise:ise06/0,
      fun ise:ise07/0,
      fun ise:ise08/0,
      fun ise:ise09/0,
      fun ise:ise10/0,
      fun ise:ise11/0,
      fun ise:ise12/0,
      fun ise:ise13/0,
      fun ise:ise14/0,
      fun ise:ise15/0,
      fun ise:ise16/0,
      fun ise:ise17/0,
      fun ise:ise18/0,
      fun ise:ise19/0,
      fun ise:ise20/0,
      fun ise:ise21/0,
      fun ise:ise22/0,
      fun ise:ise23/0,
      fun ise:ise24/0,
      fun ise:ise25/0,
      fun ise:ise26/0,
      fun ise:ise27/0,
      fun ise:ise28/0,
      fun ise:ise29/0,
      fun ise:ise30/0,
      fun ise:ise31/0,
      fun ise:ise32/0,
      fun ise:ise33/0,
      fun ise:ise34/0
     ]}.

setup() ->
    application:start(microc).

cleanup(_) ->
    application:stop(microc).

