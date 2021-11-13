create table customers (
    id integer primary key,
    name varchar(255),
    birth_date date
);

create table accounts(
    account_id varchar(40) primary key ,
    customer_id integer references customers(id),
    currency varchar(3),
    balance float,
    "limit" float
);

create table transactions (
    id serial primary key ,
    date timestamp,
    src_account varchar(40) references accounts(account_id),
    dst_account varchar(40) references accounts(account_id),
    amount float,
    status varchar(20)
);

INSERT INTO customers VALUES (201, 'John', '2021-11-05');
INSERT INTO customers VALUES (202, 'Anny', '2021-11-02');
INSERT INTO customers VALUES (203, 'Rick', '2021-11-24');

INSERT INTO accounts VALUES ('NT10204', 201, 'KZT', 1000, null);
INSERT INTO accounts VALUES ('AB10203', 202, 'USD', 100, 0);
INSERT INTO accounts VALUES ('DK12000', 203, 'EUR', 500, 200);
INSERT INTO accounts VALUES ('NK90123', 201, 'USD', 400, 0);
INSERT INTO accounts VALUES ('RS88012', 203, 'KZT', 5000, -100);

INSERT INTO transactions VALUES (1, '2021-11-05 18:00:34.000000', 'NT10204', 'RS88012', 1000, 'commited');
INSERT INTO transactions VALUES (2, '2021-11-05 18:01:19.000000', 'NK90123', 'AB10203', 500, 'rollback');
INSERT INTO transactions VALUES (3, '2021-06-05 18:02:45.000000', 'RS88012', 'NT10204', 400, 'init');

--1
-- Large-object types are stored as a large object:
-- *blob: binary large object
-- *clob: character large object

-- 2
-- *Privileges control the ability to run SQL statements.
-- *A role is a group of privileges.
-- *Database users are the ones who really use and take the benefits of the database.

create role administrator;
create role accountant;
create role support;

grant all on accounts, customers, transactions to administrator;
grant all on accounts, transactions to accountant;
grant select on customers to support;

create user Diana;
create user Ayana;
create user Dias;

grant administrator to Diana;
grant accountant to Ayana;
grant support to Dias;

alter user Dias createrole;

revoke delete on transactions from Ayana;

-- 3
-- b
alter table transactions alter column date set not null;
alter table customers alter column name set not null;
alter table accounts alter column currency set not null ;

-- 5
-- a
create index src_am on accounts(customer_id, currency);
-- b
create index cur_bal on accounts(currency, balance);

-- 6
