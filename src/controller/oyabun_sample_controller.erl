%% --------------------------------------------------------------------
%% @author Tonami SUMIYAMA <smymtnm@gmail.com>
%% @version 0.1
%% @end
%% --------------------------------------------------------------------

-module(oyabun_sample_controller, [Req, SessionId]).
-compile(export_all).

%% ====================================================================
%% API functions
%% ====================================================================

config(lang, DefaultValue, RequestContext) ->
    boss_session:get_session_data(SessionId, locale);
config(_,_,_) ->
    ok.

before_("signup", B, C) ->
    ok;
before_(A, B, C) ->
    user_lib:require_login(SessionId).

index('GET', []) ->
    {ok, []}.

display('POST', []) ->
    {json, [{result,"ok"},
            {data,[
                   {now, now()}
                   
                  ]}]};
display('GET', []) ->
    {ok, []}.
%% ====================================================================
%% Internal functions
%% ====================================================================


