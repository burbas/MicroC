%%% @author Niclas Axelsson <niclas@burbas.se>
%%% @copyright (C) 2011, Niclas Axelsson
%%% @doc
%%% EUnit test cases for lexer
%%% @end
%%% Created :  1 Sep 2010 by Niclas Axelsson
-module(lexer_test).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").
 

setup() ->
    ok.
teardown(_B) ->
    ok.


read_exception({ok, BinString}) ->
    ?_assertException(error, _, lexer:string(binary_to_list(BinString))).

read_correct({ok, BinString}) ->
    ?_assertMatch({ok, _, _}, lexer:string(binary_to_list(BinString))).

generate_test_() ->
    {inorder,
     {foreach,
      fun setup/0,
      fun teardown/1,
      [
       [read_exception(file:read_file(X)) || X <- [
						   "../priv/test_files/incorrect/lexer/bad.c", %% Contains non-terminating comment
						   "../priv/test_files/incorrect/lexer/ugly.c" %% Contains binary
						   ]],
       [read_correct(file:read_file(X)) || X <- [
						 "../priv/test_files/incorrect/lexer/long-char.c",
						 "../priv/test_files/incorrect/lexer/good.c",
						 "../priv/test_files/noisy/simple/sim01.c",
						 "../priv/test_files/noisy/simple/sim02.c",
						 "../priv/test_files/noisy/simple/sim03.c",
						 "../priv/test_files/noisy/simple/sim04.c",
						 "../priv/test_files/noisy/simple/sim05.c",
						 "../priv/test_files/noisy/simple/sim06.c",
						 "../priv/test_files/noisy/simple/sim07.c",
						 "../priv/test_files/noisy/simple/sim08.c",
						 "../priv/test_files/noisy/simple/sim09.c",
						 "../priv/test_files/noisy/simple/sim10.c",
						 "../priv/test_files/noisy/simple/sim11.c",
						 "../priv/test_files/noisy/medium/circle.c",
						 "../priv/test_files/noisy/medium/fac-b.c",
						 "../priv/test_files/noisy/medium/fac.c",
						 "../priv/test_files/noisy/medium/fib.c",
						 "../priv/test_files/noisy/advanced/8queens.c",
						 "../priv/test_files/noisy/advanced/bubble.c",
						 "../priv/test_files/noisy/advanced/eval.c",
						 "../priv/test_files/noisy/advanced/primes.c",
						 "../priv/test_files/noisy/advanced/quick.c",
						 "../priv/test_files/quiet/lexer/l01.c",
						 "../priv/test_files/quiet/lexer/l02.c",
						 "../priv/test_files/quiet/lexer/l03.c",
						 "../priv/test_files/quiet/lexer/l04.c",
						 "../priv/test_files/quiet/lexer/l05.c",
						 "../priv/test_files/quiet/lexer/l06.c"
						  ]]
      ]}}.
