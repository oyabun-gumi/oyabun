%% --------------------------------------------------------------------
%% @author Tonami SUMIYAMA <smymtnm@gmail.com>
%% @version 0.1
%% @doc Handling user module.
%% @end
%% --------------------------------------------------------------------

-module(user_lib).
-include("include/session.hrl").

%% ====================================================================
%% API functions
%% ====================================================================

-export([
    require_login/1,
    login/3,
    logout/1
]).

require_login(SessionID) ->
    case boss_session:get_session_data(SessionID, ?SESSION_USER_ID) of
        {error, _} -> {redirect, "/signup"};
        Id ->
            case boss_db:find(Id) of
                {error, _} -> {redirect, "/signup"};
                User ->
                    {ok, User}
            end
     end.

login(SessionID, UserId, Password) ->
    case check_login(UserId, Password) of
        {ok, User} ->
            % save user id in session
            boss_session:set_session_data(SessionID, ?SESSION_USER_ID, User:id()),
            {ok, User};
        {error, Message} ->
            {error, Message}
    end.

logout(SessionID) ->
    boss_session:delete_session(SessionID).


%% ====================================================================
%% Internal functions
%% ====================================================================

% @doc check user in db
-spec check_login(UserId::binary(), Password::binary())->
          Result::{ok, User::record()}|{error,Message::string()}.
check_login(UserId, Password) ->
    case boss_db:find(sysuser, [{name, 'equals', UserId}]) of
        [User] ->
            {ok, Hash} = bcrypt:hashpw(Password, User:password()),
            case list_to_binary(Hash) =:= User:password() of
                true ->
                    {ok, User};
                false ->
                    {error, "error"}
            end;
        Other ->
            {error, "error"}
    end.
