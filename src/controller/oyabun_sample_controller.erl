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


