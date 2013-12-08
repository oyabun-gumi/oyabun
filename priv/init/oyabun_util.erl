-module(oyabun_util).
-compile (export_all).
-define (APPNAME, oyabun).

%% ====================================================================
%% API functions
%% ====================================================================

init() ->
    application:start(crypto),
    application:start(bcrypt),
    ok.

%% ====================================================================
%% Internal functions
%% ====================================================================

