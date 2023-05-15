-- createuser -U postgres -P graham_s
create database vw;
\c vw
grant all privileges on database vw to graham_s;

grant all privileges on dictionaries.datasets to graham_s;
grant all privileges on dictionaries.tables to graham_s;
grant all privileges on dictionaries.variables to graham_s;
grant all privileges on dictionaries.enums to graham_s;

insert into datasets( 'comlife' )
