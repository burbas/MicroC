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
    [{incorrect, [], [{semantic, [], [ise01,ise02,ise03,ise04,ise05,ise06,ise07,ise08,ise09,ise10,ise11,ise12,
				      ise13,ise14,ise15,ise16,ise17,ise18,ise19,ise20,ise21,ise22,ise23,ise24,
				      ise25,ise26,ise27,ise28,ise29,ise30,ise31,ise32,ise33,ise34]},
		      {lexer, [], [ile01, ile02, ile03, ile04]},
		      {parser, [], [ipe01, ipe02, ipe03, ipe04, ipe05, ipe06, ipe07, ipe08, ipe09, 
				    ipe10, ipe11, ipe12, ipe13, ipe14]}]}].

%%--------------------------------------------------------------------
%% @spec all() -> GroupsAndTestCases | {skip,Reason}
%% GroupsAndTestCases = [{group,GroupName} | TestCase]
%% GroupName = atom()
%% TestCase = atom()
%% Reason = term()
%% @end
%%--------------------------------------------------------------------
all() -> 
    [{group, incorrect}].
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
    {error, not_found, b} = mrh:helper(?CTPATH,"se01.c").

ise02(_Config) ->
    {error, not_found, foo} = mrh:helper(?CTPATH,"se02.c").

ise03(_Config) ->
    {error, not_found, output} = mrh:helper(?CTPATH,"se03.c").
 
ise04(_Config) ->
    {error, already_decleared} = mrh:helper(?CTPATH,"se04.c").

ise05(_Config) ->
    {error, already_decleared} = mrh:helper(?CTPATH,"se05.c").
   
ise06(_Config) ->
    {error, already_decleared} = mrh:helper(?CTPATH,"se06.c").

ise07(_Config) ->
    {error, return_missmatch} = mrh:helper(?CTPATH,"se07.c").

ise08(_Config) ->
    {error, return_missmatch} = mrh:helper(?CTPATH,"se08.c").
    
ise09(_Config) ->
    {error, return_missmatch} = mrh:helper(?CTPATH,"se09.c").
   
ise10(_Config) ->
    {error, not_found, n} = mrh:helper(?CTPATH,"se10.c").
    
ise11(_Config) ->
    {error, incompatible_types} = mrh:helper(?CTPATH,"se11.c").
    
ise12(_Config) ->
    {error, not_found, a} = mrh:helper(?CTPATH,"se12.c").
    
ise13(_Config) ->
    {error, unmatched_types} = mrh:helper(?CTPATH,"se13.c").
   
ise14(_Config) ->
    {error, not_found, f} = mrh:helper(?CTPATH,"se14.c").
   
ise15(_Config) ->
    {error, not_same_type} = mrh:helper(?CTPATH,"se15.c").
    
ise16(_Config) ->
    {error, not_same_type} = mrh:helper(?CTPATH,"se16.c").
   
ise17(_Config) ->
    {error, illegal_pointer} = mrh:helper(?CTPATH,"se17.c").
    
ise18(_Config) ->
    {error, illegal_pointer} = mrh:helper(?CTPATH,"se18.c").
    
ise19(_Config) ->
    {error, illegal_pointer} = mrh:helper(?CTPATH,"se19.c").
    
ise20(_Config) ->
    {error,illegal_pointer} = mrh:helper(?CTPATH,"se20.c").
    
ise21(_Config) ->
    {error,return_missmatch} = mrh:helper(?CTPATH,"se21.c").
    
ise22(_Config) ->
    {error,illegal_pointer} = mrh:helper(?CTPATH,"se22.c").
   
ise23(_Config) ->
    {error, not_found, b} = mrh:helper(?CTPATH,"se23.c").
   
ise24(_Config) ->
    {error,illegal_pointer} = mrh:helper(?CTPATH,"se24.c").
   
ise25(_Config) ->
    {error, no_assignment} = mrh:helper(?CTPATH,"se25.c").
    
ise26(_Config) ->
    {error,not_same_type} = mrh:helper(?CTPATH,"se26.c").
    
ise27(_Config) ->
    {error,return_missmatch} = mrh:helper(?CTPATH,"se27.c").
    
ise28(_Config) ->
    {error,return_missmatch} = mrh:helper(?CTPATH,"se28.c").
    
ise29(_Config) ->
    {error,already_declared} = mrh:helper(?CTPATH,"se29.c").
    
ise30(_Config) ->
    {error,illegal_pointer} = mrh:helper(?CTPATH,"se30.c").
    
ise31(_Config) ->
    {error,already_declared} = mrh:helper(?CTPATH,"se31.c").
    
ise32(_Config) ->
    {error,unmatched_types} = mrh:helper(?CTPATH,"se32.c").
    
ise33(_Config) ->
    {error,not_same_type} = mrh:helper(?CTPATH,"se33.c").
    
ise34(_Config) ->
    {error,not_same_type} = mrh:helper(?CTPATH,"se34.c").
    


