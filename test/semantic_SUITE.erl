%%%-------------------------------------------------------------------
%%% @author Daniel <daniel@minidaniel>
%%% @copyright (C) 2011, Daniel
%%% @doc
%%%
%%% @end
%%% Created : 30 Jun 2011 by Daniel <daniel@minidaniel>
%%%-------------------------------------------------------------------
-module(semantic_SUITE).

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
    [{incorrect_semantic, [sequence], [ise01,ise02,ise03,ise04,ise05,ise06,ise07,ise08,ise09,ise10,ise11,ise12,
				       ise13,ise14,ise15,ise16,ise17,ise18,ise19,ise20,ise21,ise22,ise23,ise24,
				       ise25,ise26,ise27,ise28,ise29,ise30,ise31,ise32,ise33,ise34]}].

%%--------------------------------------------------------------------
%% @spec all() -> GroupsAndTestCases | {skip,Reason}
%% GroupsAndTestCases = [{group,GroupName} | TestCase]
%% GroupName = atom()
%% TestCase = atom()
%% Reason = term()
%% @end
%%--------------------------------------------------------------------
all() -> 
    [{group, incorrect_semantic}].
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
    {error, not_found, b} = helper("se01.c").

ise02(_Config) ->
    {error, not_found, foo} = helper("se02.c").

ise03(_Config) ->
    {error, not_found, output} = helper("se03.c").
 
ise04(_Config) ->
    {error, already_decleared} = helper("se04.c").

ise05(_Config) ->
    {error, already_decleared} = helper("se05.c").
   
ise06(_Config) ->
    {error, already_decleared} = helper("se06.c").

ise07(_Config) ->
    {error, return_missmatch} = helper("se07.c").

ise08(_Config) ->
    {error, return_missmatch} = helper("se08.c").
    
ise09(_Config) ->
    {error, return_missmatch} = helper("se09.c").
   
ise10(_Config) ->
    {error, not_found, n} = helper("se10.c").
    
ise11(_Config) ->
    {error, incompatible_types} = helper("se11.c").
    
ise12(_Config) ->
    {error, not_found, a} = helper("se12.c").
    
ise13(_Config) ->
    {error, unmatched_types} = helper("se13.c").
   
ise14(_Config) ->
    {error, not_found, f} = helper("se14.c").
   
ise15(_Config) ->
    {error, not_same_type} = helper("se15.c").
    
ise16(_Config) ->
    {error, not_same_type} = helper("se16.c").
   
ise17(_Config) ->
    {error, illegal_pointer} = helper("se17.c").
    
ise18(_Config) ->
    {error, illegal_pointer} = helper("se18.c").
    
ise19(_Config) ->
    {error, illegal_pointer} = helper("se19.c").
    
ise20(_Config) ->
    {error,illegal_pointer} = helper("se20.c").
    
ise21(_Config) ->
    {error,return_missmatch} = helper("se21.c").
    
ise22(_Config) ->
    {error,illegal_pointer} = helper("se22.c").
   
ise23(_Config) ->
    {error, not_found, b} = helper("se23.c").
   
ise24(_Config) ->
    {error,illegal_pointer} = helper("se24.c").
   
ise25(_Config) ->
    {error, no_assignment} = helper("se25.c").
    
ise26(_Config) ->
    {error,not_same_type} = helper("se26.c").
    
ise27(_Config) ->
    {error,return_missmatch} = helper("se27.c").
    
ise28(_Config) ->
    {error,return_missmatch} = helper("se28.c").
    
ise29(_Config) ->
    {error,already_declared} = helper("se29.c").
    
ise30(_Config) ->
    {error,illegal_pointer} = helper("se30.c").
    
ise31(_Config) ->
    {error,already_declared} = helper("se31.c").
    
ise32(_Config) ->
    {error,unmatched_types} = helper("se32.c").
    
ise33(_Config) ->
    {error,not_same_type} = helper("se33.c").
    
ise34(_Config) ->
    {error,not_same_type} = helper("se34.c").
    


helper(File) ->
    case catch microc:compile(?CTPATH++File) of
	{'EXIT', Error} ->
	    Error;
	A ->
	    A
    end.
