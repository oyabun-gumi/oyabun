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

before_("signup", _, _) ->
    ok;
before_("lang", _, _) ->
    ok;
before_(_, _, _) ->
    user_lib:require_login(SessionId).

% @doc select language event
lang('GET', [Lang], _) ->
    boss_session:set_session_data(SessionId, locale, Lang),
    lager:info("Req:header(referer)=~p", [Req:header(referer)]),
    {redirect, Req:header(referer), [{"Content-Language", boss_session:get_session_data(SessionId, locale)}]}.

dashboard('GET', [], _) ->
    {ok, []}.

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

signout('GET', [], _) ->
    % delete session
    user_lib:logout(SessionId),
    {redirect, "/", []}.

%% ====================================================================
%% Internal functions
%% ====================================================================


