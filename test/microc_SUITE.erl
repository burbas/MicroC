%%%-------------------------------------------------------------------
%%% @author Daniel <daniel@minidaniel>
%%% @copyright (C) 2011, Daniel
%%% @doc
%%%
%%% @end
%%% Created : 30 Jun 2011 by Daniel <daniel@minidaniel>
%%%-------------------------------------------------------------------
-module(microc_SUITE).

-compile(export_all).

-include_lib("common_test/include/ct.hrl").
-include("path.hrl").

%%--------------------------------------------------------------------
%% @spec suite() -> Info
%% Info = [tuple()]
%% @end
%%--------------------------------------------------------------------
suite() ->
    [{timetrap,{seconds,30}}].

%%--------------------------------------------------------------------
%% @spec init_per_suite(Config0) ->
%%     Config1 | {skip,Reason} | {skip_and_save,Reason,Config1}
%% Config0 = Config1 = [tuple()]
%% Reason = term()
%% @end
%%--------------------------------------------------------------------
init_per_suite(Config) ->
    Config.

%%--------------------------------------------------------------------
%% @spec end_per_suite(Config0) -> void() | {save_config,Config1}
%% Config0 = Config1 = [tuple()]
%% @end
%%--------------------------------------------------------------------
end_per_suite(_Config) ->
    ok.

%%--------------------------------------------------------------------
%% @spec init_per_group(GroupName, Config0) ->
%%               Config1 | {skip,Reason} | {skip_and_save,Reason,Config1}
%% GroupName = atom()
%% Config0 = Config1 = [tuple()]
%% Reason = term()
%% @end
%%--------------------------------------------------------------------
init_per_group(_GroupName, Config) ->
    Config.

%%--------------------------------------------------------------------
%% @spec end_per_group(GroupName, Config0) ->
%%               void() | {save_config,Config1}
%% GroupName = atom()
%% Config0 = Config1 = [tuple()]
%% @end
%%--------------------------------------------------------------------
end_per_group(_GroupName, _Config) ->
    ok.

%%--------------------------------------------------------------------
%% @spec init_per_testcase(TestCase, Config0) ->
%%               Config1 | {skip,Reason} | {skip_and_save,Reason,Config1}
%% TestCase = atom()
%% Config0 = Config1 = [tuple()]
%% Reason = term()
%% @end
%%--------------------------------------------------------------------
init_per_testcase(_TestCase, Config) ->
    application:start(microc),
    Config.

%%--------------------------------------------------------------------
%% @spec end_per_testcase(TestCase, Config0) ->
%%               void() | {save_config,Config1} | {fail,Reason}
%% TestCase = atom()
%% Config0 = Config1 = [tuple()]
%% Reason = term()
%% @end
%%--------------------------------------------------------------------
end_per_testcase(_TestCase, _Config) ->
    application:stop(microc).

%%--------------------------------------------------------------------
%% @spec groups() -> [Group]
%% Group = {GroupName,Properties,GroupsAndTestCases}
%% GroupName = atom()
%% Properties = [parallel | sequence | Shuffle | {RepeatType,N}]
%% GroupsAndTestCases = [Group | {group,GroupName} | TestCase]
%% TestCase = atom()
%% Shuffle = shuffle | {shuffle,{integer(),integer(),integer()}}
%% RepeatType = repeat | repeat_until_all_ok | repeat_until_all_fail |
%%              repeat_until_any_ok | repeat_until_any_fail
%% N = integer() | forever
%% @end
%%--------------------------------------------------------------------
groups() ->
    [{incorrect, [parallel], [{semantic, [], [ise01,ise02,ise03,ise04,ise05,ise06,ise07,ise08,ise09,ise10,ise11,ise12,
				      ise13,ise14,ise15,ise16,ise17,ise18,ise19,ise20,ise21,ise22,ise23,ise24,
				      ise25,ise26,ise27,ise28,ise29,ise30,ise31,ise32,ise33,ise34, ise35]},
		      {lexer, [], [ile01, ile02, ile03, ile04]},
		      {parser, [], [ipe01, ipe02, ipe03, ipe04, ipe05, ipe06, ipe07, ipe08, ipe09, 
				    ipe10, ipe11, ipe12, ipe13, ipe14]}
			     ]
     },
     {correct, [], [{semantic, [], [se_noicy_adv01, se_noicy_adv02, se_noicy_adv03, se_noicy_adv04, se_noicy_med01, 
				    se_noicy_med02, se_noicy_med03, se_noicy_med04, se_noicy_sim01, se_noicy_sim02, 
				    se_noicy_sim03, se_noicy_sim04, se_noicy_sim05, se_noicy_sim06, se_noicy_sim07, 
				    se_noicy_sim08, se_noicy_sim09, se_noicy_sim10, se_noicy_sim11, se_quiet01,
				    se_quiet02, se_quiet03, se_quiet04, se_quiet05, se_quiet06]},
		    {lexer, [], []},
		    {parser, [], []}]}
    ].

%%--------------------------------------------------------------------
%% @spec all() -> GroupsAndTestCases | {skip,Reason}
%% GroupsAndTestCases = [{group,GroupName} | TestCase]
%% GroupName = atom()
%% TestCase = atom()
%% Reason = term()
%% @end
%%--------------------------------------------------------------------
all() -> 
    [{group, incorrect}, {group, correct}].
    %% [ise01,ise02,ise03,ise04,ise05,ise06,ise07,ise08,ise09,ise10,ise11,ise12,
    %%  ise13,ise14,ise15,ise16,ise17,ise18,ise19,ise20,ise21,ise22,ise23,ise24,
    %%  ise25,ise26,ise27,ise28,ise29,ise30,ise31,ise32,ise33,ise34]




%%--------------------------------------------------------------------
%% @spec TestCase() -> Info
%% Info = [tuple()]
%% @end
%%--------------------------------------------------------------------
my_test_case() -> 
    [].

%%--------------------------------------------------------------------
%% @spec TestCase(Config0) ->
%%               ok | exit() | {skip,Reason} | {comment,Comment} |
%%               {save_config,Config1} | {skip_and_save,Reason,Config1}
%% Config0 = Config1 = [tuple()]
%% Reason = term()
%% Comment = term()
%% @end
%%--------------------------------------------------------------------
ise01(_Config) ->
    {error, not_found, [b]} = mrh:helper(?CTPATH,"incorrect/semantic/se01.c").

ise02(_Config) ->
    {error, not_found, [foo]} = mrh:helper(?CTPATH,"incorrect/semantic/se02.c").

ise03(_Config) ->
    {error, not_found, [output]} = mrh:helper(?CTPATH,"incorrect/semantic/se03.c").
 
ise04(_Config) ->
    {error, already_declared, [a]} = mrh:helper(?CTPATH,"incorrect/semantic/se04.c").

ise05(_Config) ->
    {error, already_declared, [a]} = mrh:helper(?CTPATH,"incorrect/semantic/se05.c").
   
ise06(_Config) ->
    {error, already_declared, [a]} = mrh:helper(?CTPATH,"incorrect/semantic/se06.c").

ise07(_Config) ->
    {error, return_mismatch, [a, void, var, int]} = mrh:helper(?CTPATH,"incorrect/semantic/se07.c").

ise08(_Config) ->
    {error, return_mismatch, [a, int, const, void]} = mrh:helper(?CTPATH,"incorrect/semantic/se08.c").
    
ise09(_Config) ->
    {error, return_mismatch, [a, int, dirty_array, char]} = mrh:helper(?CTPATH,"incorrect/semantic/se09.c").
   
ise10(_Config) ->
    {error, not_found, [n]} = mrh:helper(?CTPATH,"incorrect/semantic/se10.c").
    
ise11(_Config) ->
    {error,incompatible_types,[{function_type,[void],int},int]} = mrh:helper(?CTPATH,"incorrect/semantic/se11.c").
    
ise12(_Config) ->
    {error, not_found, [a]} = mrh:helper(?CTPATH,"incorrect/semantic/se12.c").
    
ise13(_Config) ->
    {error, unmatched_types, [main, int, void]} = mrh:helper(?CTPATH,"incorrect/semantic/se13.c").
   
ise14(_Config) ->
    {error, not_found, [f]} = mrh:helper(?CTPATH,"incorrect/semantic/se14.c").
   
ise15(_Config) ->
    {error, type_mismatch, [[int,int,int],[int,int]]} = mrh:helper(?CTPATH,"incorrect/semantic/se15.c").
    
ise16(_Config) ->
    {error, type_mismatch, [[int,int],[int,int,int]]} = mrh:helper(?CTPATH,"incorrect/semantic/se16.c").
   
ise17(_Config) ->
    {error, illegal_pointer, []} = mrh:helper(?CTPATH,"incorrect/semantic/se17.c").
    
ise18(_Config) ->
    {error, illegal_pointer, []} = mrh:helper(?CTPATH,"incorrect/semantic/se18.c").
    
ise19(_Config) ->
    {error, illegal_pointer, []} = mrh:helper(?CTPATH,"incorrect/semantic/se19.c").
    
ise20(_Config) ->
    {error,illegal_pointer, []} = mrh:helper(?CTPATH,"incorrect/semantic/se20.c").
    
ise21(_Config) ->
    {error,return_mismatch, [a, int, dirty_array, char]} = mrh:helper(?CTPATH,"incorrect/semantic/se21.c").
    
ise22(_Config) ->
    {error,illegal_pointer, []} = mrh:helper(?CTPATH,"incorrect/semantic/se22.c").
   
ise23(_Config) ->
    {error, not_found, [b]} = mrh:helper(?CTPATH,"incorrect/semantic/se23.c").
   
ise24(_Config) ->
    {error,illegal_pointer, []} = mrh:helper(?CTPATH,"incorrect/semantic/se24.c").
   
ise25(_Config) ->
    {error, no_assignment, []} = mrh:helper(?CTPATH,"incorrect/semantic/se25.c").
    
ise26(_Config) ->
    {error,type_mismatch, [[{array, int}], [{array, char}]]} = mrh:helper(?CTPATH,"incorrect/semantic/se26.c").
    
ise27(_Config) ->
    {error,return_mismatch, [a, void, var, int]} = mrh:helper(?CTPATH,"incorrect/semantic/se27.c").
    
ise28(_Config) ->
    {error,return_mismatch, [a, void, var, int]} = mrh:helper(?CTPATH,"incorrect/semantic/se28.c").
    
ise29(_Config) ->
    {error,already_declared, [n]} = mrh:helper(?CTPATH,"incorrect/semantic/se29.c").
    
ise30(_Config) ->
    {error,illegal_pointer, []} = mrh:helper(?CTPATH,"incorrect/semantic/se30.c").
    
ise31(_Config) ->
    {error,already_declared, [a]} = mrh:helper(?CTPATH,"incorrect/semantic/se31.c").
    
ise32(_Config) ->
    {error,unmatched_types, [main, int, void]} = mrh:helper(?CTPATH,"incorrect/semantic/se32.c").
    
ise33(_Config) ->
    {error,type_mismatch, [[int,int,int],[int,int]]} = mrh:helper(?CTPATH,"incorrect/semantic/se33.c").
    
ise34(_Config) ->
    {error,type_mismatch, [[int,int],[int,int,int]]} = mrh:helper(?CTPATH,"incorrect/semantic/se34.c").

ise35(_Config) ->    
    {error, return_mismatch, [g, char, dirty_array, char]} = mrh:helper(?CTPATH, "incorrect/semantic/se35.c").


ile01(_Config) ->
    {error, _Info, _Row} = mrh:lexer_helper(?CTPATH, "incorrect/lexer/bad.c").

ile02(_Config) ->
    %% This is correct for the lexer, but should throw an exception when read by the parser
    {ok, _Tokens, _Rows} = mrh:lexer_helper(?CTPATH, "incorrect/lexer/good.c").

ile03(_Config) ->
    {error, _Info, _Row} = mrh:lexer_helper(?CTPATH, "incorrect/lexer/long-char.c").

ile04(_Config) ->
    {error, _Info, _Row} = mrh:lexer_helper(?CTPATH, "incorrect/lexer/ugly.c").

ipe01(_Config) ->
    {{{badmatch,_},_},_} = mrh:parser_helper(?CTPATH, "incorrect/parser/pe01.c").

ipe02(_Config) ->
    {{{badmatch,_},_},_} = mrh:parser_helper(?CTPATH, "incorrect/parser/pe02.c").

ipe03(_Config) ->
    {{{badmatch,_},_},_} = mrh:parser_helper(?CTPATH, "incorrect/parser/pe03.c").

ipe04(_Config) ->
    {{{badmatch,_},_},_} = mrh:parser_helper(?CTPATH, "incorrect/parser/pe04.c").

ipe05(_Config) ->
    {{{badmatch,_},_},_} = mrh:parser_helper(?CTPATH, "incorrect/parser/pe05.c").

ipe06(_Config) ->
    {{{badmatch,_},_},_} = mrh:parser_helper(?CTPATH, "incorrect/parser/pe06.c").

ipe07(_Config) ->
    {{{badmatch,_},_},_} = mrh:parser_helper(?CTPATH, "incorrect/parser/pe07.c").

ipe08(_Config) ->
    {{{badmatch,_},_},_} = mrh:parser_helper(?CTPATH, "incorrect/parser/pe08.c").

ipe09(_Config) ->
    {{{badmatch,_},_},_} = mrh:parser_helper(?CTPATH, "incorrect/parser/pe09.c").

ipe10(_Config) ->
    {{{badmatch,_},_},_} = mrh:parser_helper(?CTPATH, "incorrect/parser/pe10.c").

ipe11(_Config) ->
    {{{badmatch,_},_},_} = mrh:parser_helper(?CTPATH, "incorrect/parser/pe11.c").

ipe12(_Config) ->
    {{{badmatch,_},_},_} = mrh:parser_helper(?CTPATH, "incorrect/parser/pe12.c").

ipe13(_Config) ->
    {{{badmatch,_},_},_} = mrh:parser_helper(?CTPATH, "incorrect/parser/pe13.c").

ipe14(_Config) ->
    {{{badmatch,_},_},_} = mrh:parser_helper(?CTPATH, "incorrect/parser/pe14.c").


%%%%% CORRECT CASES %%%%%%%%
se_noicy_adv01(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "noisy/advanced/8queens.c").

se_noicy_adv02(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "noisy/advanced/bubble.c").

se_noicy_adv03(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "noisy/advanced/eval.c").

se_noicy_adv04(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "noisy/advanced/primes.c").

se_noicy_adv05(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "noisy/advanced/quick.c").

se_noicy_med01(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "noisy/medium/circle.c").

se_noicy_med02(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "noisy/medium/fac-b.c").

se_noicy_med03(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "noisy/medium/fac.c").

se_noicy_med04(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "noisy/medium/fib.c").


se_noicy_sim01(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "noisy/simple/sim01.c").

se_noicy_sim02(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "noisy/simple/sim02.c").

se_noicy_sim03(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "noisy/simple/sim03.c").

se_noicy_sim04(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "noisy/simple/sim04.c").

se_noicy_sim05(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "noisy/simple/sim05.c").

se_noicy_sim06(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "noisy/simple/sim06.c").

se_noicy_sim07(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "noisy/simple/sim07.c").

se_noicy_sim08(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "noisy/simple/sim08.c").

se_noicy_sim09(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "noisy/simple/sim09.c").

se_noicy_sim10(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "noisy/simple/sim10.c").

se_noicy_sim11(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "noisy/simple/sim11.c").


se_quiet01(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "quiet/semantic/s01.c").

se_quiet02(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "quiet/semantic/s02.c").

se_quiet03(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "quiet/semantic/s03.c").

se_quiet04(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "quiet/semantic/s04.c").

se_quiet05(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "quiet/semantic/s05.c").

se_quiet06(_Config) ->
    {ok, _} = mrh:helper(?CTPATH, "quiet/semantic/s06.c").
