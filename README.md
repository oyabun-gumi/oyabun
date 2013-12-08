OYABUN
======

OYABUN is a Web application sample by Erlang.  
This is configured by using the following framework.

* [ChicagoBoss](http://www.chicagoboss.org/)
* [AngularJS](http://angularjs.org/)
* [Bootstrap](http://getbootstrap.com/)

---

## Run

* get project  
  `git clone https://github.com/oyabun-gumi/oyabun.git`

* move oyabun dir
* get deps

  `./rebar get-deps`
  
* compile
  
    `./rebar compile`
    
* Create DB
  * OYABUN use postgres. (DB name oyabun)
* write boss.config file as follows:

        {db_host, "localhost"},
        {db_port, 5432},
        {db_adapter, pgsql},
        {db_username, "postgres"},
        {db_password, "postgres"},
        {db_database, "oyabun"}

* start server

  `./init-dev.sh`

* migrate table

  `boss_migrate:run(gsd_web).`
  
  
* access page [http://localhost:8001/](http://localhost:8001/)
    * userid / pass = admin /admin
