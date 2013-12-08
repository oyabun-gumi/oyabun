%% Migration: create_sysusers

{create_sysusers,
  fun(up) -> 
    boss_db:execute(
        "CREATE TABLE sysusers (
          id bigserial PRIMARY KEY,
          name text,
          password text,
          registration_datetime timestamp without time zone NOT NULL DEFAULT now(),
          last_update_datetime timestamp without time zone NOT NULL DEFAULT now(),
          ver bigint NOT NULL DEFAULT 0
        )"
        ),

    % create admin user
    Password = "admin",
    Workfactor = 10,
    {ok, Salt} = bcrypt:gen_salt(Workfactor),
    {ok, Hash} = bcrypt:hashpw(Password, Salt),

    AdminUser = boss_record:new(sysuser, [{name, "admin"}, {password, Hash}]),
    AdminUser:save();

    (down) -> 
        boss_db:execute("DROP TABLE sysusers")
  end}.
