%% --------------------------------------------------------------------
%% @author Tonami SUMIYAMA <smymtnm@gmail.com>
%% @version 0.1
%% @end
%% --------------------------------------------------------------------

-module(oyabun_admin_controller, [Req, SessionId]).
-compile(export_all).

%% ====================================================================
%% API functions
%% ====================================================================
before_("signup", B, C) ->
    ok;
before_(A, B, C) ->
    user_lib:require_login(SessionId).

index('GET', [], User) ->
    {ok, []}.

signup('GET', [], _) ->
    {ok, []};
signup('POST', [], _) ->
    Data = request_lib:param(Req:request_body()),
    Password = proplists:get_value(password, Data),
    UserId = proplists:get_value(loginid, Data),
    
    case user_lib:login(SessionId, UserId, Password) of
        {error, Message} ->
            % update screen
            {json, [{result,"error"},{data,[{message, Message}]}]};
        _ ->
            {json, [{result,"ok"},{data,[{url, "/"}]}]}
    end.

signout('POST', [], _) ->
    % delete session
    user_lib:logout(SessionId),
    {json, [{result,"ok"},{data,[{url, "/"}]}]}.

%% ====================================================================
%% Internal functions
%% ====================================================================


