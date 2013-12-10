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

config(lang, DefaultValue, RequestContext) ->
    boss_session:get_session_data(SessionId, locale);
config(_,_,_) ->
    ok.

before_("signup", B, C) ->
    ok;
before_("japanese", B, C) ->
    ok;
before_("english", B, C) ->
    ok;
before_(A, B, C) ->
    user_lib:require_login(SessionId).

english('GET', [], _) ->
    boss_session:set_session_data(SessionId, locale, "en"),
    {redirect, Req:header(referer), [{"Content-Language", boss_session:get_session_data(SessionId, locale)}]}.
japanese('GET', [], _) ->
    boss_session:set_session_data(SessionId, locale, "ja"),
    {redirect, Req:header(referer), [{"Content-Language", boss_session:get_session_data(SessionId, locale)}]}.

signup('GET', [], U) ->
    {ok, [{is_not_login, "true"}]};
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


