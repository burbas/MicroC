%%% @author Niclas Axelsson <burbas@niclas-axelssons-macbook-pro.local>
%%% @copyright (C) 2011, Niclas Axelsson
%%% @doc
%%%
%%% @end
%%% Created : 14 Jul 2011 by Niclas Axelsson <burbas@niclas-axelssons-macbook-pro.local>

-module(rtl_print).


-include("../include/rtl.hrl").

-export([print/1]).

print([]) ->
    ok;
print([#'RTL_DATA'{label = Label, size = Size}|Tl]) ->
    io:format("(data ~p ~p)~n", [Label, Size]),
    print(Tl);
print([#'RTL_PROC'{label = Label, formals = Formals, locals = Locals, framesize = FrameSize, insns = Insns}|Tl]) ->
    io:format("(procedure ~p~n", [Label]),
    io:format("(formals ~p)~n", [Formals]),
    io:format("(locals ~p)~n", [Locals]),
    io:format("(framesize ~p)~n", [FrameSize]),
    print(Insns),
    io:format(")~n"),
    print(Tl);
print([#'RTL_CALL'{function = Function, arguments = Arguments}|Tl]) ->
    print(Tl);
print([#'RTL_TEMP'{temp = Temp}|Tl]) ->
    io:format("~p ", Temp),
    print(Tl);
print([#'RTL_LABELDEF'{label = Label}|Tl]) ->
    io:format("~p:~n", [Label]),
    print(Tl);
print([#'RTL_EVAL'{dest = Dest, value = Value}|Tl]) ->
    io:format("(set ~p ~p)~n", [Dest, Value]),
    print(Tl);
print([#'RTL_SUB'{temp1 = Temp1, temp2 = Temp2}|Tl]) ->
    io:format("(sub ~p ~p)~n", [Temp1, Temp2]),
    print(Tl);
print([#'RTL_MUL'{temp1 = Temp1, temp2 = Temp2}|Tl]) ->
    io:format("(mul ~p ~p)~n", [Temp1, Temp2]),
    print(Tl);
print([#'RTL_ADD'{temp1 = Temp1, temp2 = Temp2}|Tl]) ->
    io:format("(add ~p ~p)~n", [Temp1, Temp2]),
    print(Tl);
print([#'RTL_DIV'{temp1 = Temp1, temp2 = Temp2}|Tl]) ->
    io:format("(div ~p ~p)~n", [Temp1, Temp2]),
    print(Tl);
print([#'RTL_COMMENT'{text = Text}|Tl]) ->
    io:format("(comment: ~p)~n", [Text]),
    print(Tl);
print([#'RTL_CJUMP'{relop = Relop, temp1 = Temp1, temp2 = Temp2, label = Label}|Tl]) ->
    io:format("(if (~p ~p ~p) goto ~p)~n", [Relop, Temp1, Temp2, Label]),
    print(Tl);

print([_|Tl]) ->
    print(Tl).

