%%%-------------------------------------------------------------------
%%% @author Niclas Axelsson <burbas@niclas-axelssons-macbook-pro.local>
%%% @copyright (C) 2010, Niclas Axelsson
%%% @doc
%%%
%%% @end
%%% Created : 10 Nov 2010 by Niclas Axelsson <burbas@niclas-axelssons-macbook-pro.local>
%%%-------------------------------------------------------------------
-module(microc).

-behaviour(gen_server).

%% API
-export([
	 start_link/0,
	 lex/1,
	 parse/1,
	 compile/1
	]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
	 terminate/2, code_change/3]).

-define(SERVER, ?MODULE). 

-record(state, {}).

%%%===================================================================
%%% API
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% Starts the server
%%
%% @spec start_link() -> {ok, Pid} | ignore | {error, Error}
%% @end
%%--------------------------------------------------------------------
start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).


lex(Filename) ->
    gen_server:call(?SERVER, {lex, Filename}).

parse(Filename) ->
    {_, Tokens, _} = gen_server:call(?SERVER, {lex, Filename}),
    gen_server:call(?SERVER, {parse, Tokens}).

compile(Filename) ->
    gen_server:call(?SERVER, {compile, Filename}).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Initializes the server
%%
%% @spec init(Args) -> {ok, State} |
%%                     {ok, State, Timeout} |
%%                     ignore |
%%                     {stop, Reason}
%% @end
%%--------------------------------------------------------------------
init([]) ->
    {ok, #state{}}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling call messages
%%
%% @spec handle_call(Request, From, State) ->
%%                                   {reply, Reply, State} |
%%                                   {reply, Reply, State, Timeout} |
%%                                   {noreply, State} |
%%                                   {noreply, State, Timeout} |
%%                                   {stop, Reason, Reply, State} |
%%                                   {stop, Reason, State}
%% @end
%%--------------------------------------------------------------------
handle_call({lex, Filename}, _From, State) ->
    case file:read_file(Filename) of
	{ok, Binary} ->
	    ContentList = erlang:binary_to_list(Binary),
	    Return = tokenize(ContentList),
	    {reply, Return, State};
	Error ->
	    {reply, Error, State}
    end;

handle_call({parse, Tokens}, _From, State) ->
    {ok, AST} = parser:parse(Tokens),
    {reply, AST, State};

handle_call({compile, Filename}, _From, State) ->
    case file:read_file(Filename) of
	{ok, Binary} ->
	    ContentList = erlang:binary_to_list(Binary),
	    
%	    try 
		{_, Tokens, _} = tokenize(ContentList),
		{ok, AST} = parser:parse(Tokens),
		_Semantic = absyn:analyze(AST),
		{reply, AST, State};
%	    catch
%		P:Reason -> io:format("~p: ~p~n", [P, Reason]),
%			       {reply, ok, State}
%	    end;
	Error ->
	    {reply, Error, State}
    end;
handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling cast messages
%%
%% @spec handle_cast(Msg, State) -> {noreply, State} |
%%                                  {noreply, State, Timeout} |
%%                                  {stop, Reason, State}
%% @end
%%--------------------------------------------------------------------
handle_cast(_Msg, State) ->
    {noreply, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling all non call/cast messages
%%
%% @spec handle_info(Info, State) -> {noreply, State} |
%%                                   {noreply, State, Timeout} |
%%                                   {stop, Reason, State}
%% @end
%%--------------------------------------------------------------------
handle_info(_Info, State) ->
    {noreply, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% This function is called by a gen_server when it is about to
%% terminate. It should be the opposite of Module:init/1 and do any
%% necessary cleaning up. When it returns, the gen_server terminates
%% with Reason. The return value is ignored.
%%
%% @spec terminate(Reason, State) -> void()
%% @end
%%--------------------------------------------------------------------
terminate(_Reason, _State) ->
    ok.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Convert process state when code is changed
%%
%% @spec code_change(OldVsn, State, Extra) -> {ok, NewState}
%% @end
%%--------------------------------------------------------------------
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
tokenize(String) ->
    lexer:string(String).
