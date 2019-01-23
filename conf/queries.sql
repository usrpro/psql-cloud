-- name: create_usrpro_user!
-- Create the usrpro user if it does not exist.
do $$
begin
    create user usrpro;
    exception when others then
    raise notice 'usrpro user not created -- already exists';
end
$$;

-- name: create_health_user!
-- Create the health user if it does not exist.
do $$
begin
    create user health;
    exception when others then
    raise notice 'health user not created -- already exists';
end
$$;

-- name: grant_health!
-- Grant connect permission for the health user
grant connect
    on database postgres
    to health;

-- name: update_pw!
alter
    user usrpro
    password :pw;

-- name: check_db
-- check if a db exists
select 1
    from pg_database
    where datname = %s;

-- name: create_usrpro_db!
-- create the usrpro db
create
    database usrpro
    owner usrpro;

-- name: create_cecas_db!
-- create the cecas db
create
    database cecas
    owner usrpro;

-- name: create_neosib_db!
-- create the neosib db
create
    database neosib
    owner usrpro;
