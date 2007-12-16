create table user (
  user_id integer auto_increment,
  unixid integer,
  username varchar(100),
  fullname varchar(100),
  contact varchar(100),
  primary key (user_id)
);

create table transaction (
  transaction_id integer auto_increment,
  user_id integer,
  txndate datetime,
  amount float,
  description varchar(200),
  primary key (transaction_id)
);

create view my_user as
  select *
    from user
   where username = SUBSTRING_INDEX(USER(),'@',1);

create view my_transaction as
  select transaction.*
    from transaction, user
   where username = SUBSTRING_INDEX(USER(),'@',1)
     and transaction.user_id = user.user_id;

