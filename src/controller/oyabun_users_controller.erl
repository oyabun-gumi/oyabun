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
list('GET', [Id], _) ->
    {ok, []}.
edit('GET', [Id], _) ->
    {ok, []}.
view('GET', [Id], _) ->
    {ok, []}.

%% ====================================================================
%% Internal functions
%% ====================================================================


