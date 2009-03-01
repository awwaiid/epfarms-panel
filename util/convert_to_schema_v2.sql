drop table accounts;
drop table domains;
drop table methods;
drop view my_transactions;
drop view my_users;

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL auto_increment,
  `username` varchar(50) default NULL,
  `name` varchar(100) default NULL,
  `external_email` varchar(100) default NULL,
  `contact` varchar(100) default NULL,
  `username_mysql` varchar(100) default NULL,
  `unixid` int(11) default NULL,
  PRIMARY KEY  (`user_id`)
);

create view my_user as
  select *
    from user
   where username_mysql = SUBSTRING_INDEX(USER(),'@',1);

INSERT INTO user (username, name, external_email, contact, username_mysql, unixid)
SELECT usr_nname, usr_name, usr_external_email, usr_contact,
       usr_mysql_username, usr_efid
  FROM users;

CREATE TABLE `transaction` (
  `transaction_id` int(11) NOT NULL auto_increment,
  `transaction_time` datetime default NULL,
  `amount` float default NULL,
  `description` varchar(100) default NULL,
  `reference_number` varchar(100) default NULL,
  `user_id` int(11) default NULL,
  `subscription_id` int(11) default NULL,
  PRIMARY KEY  (`transaction_id`)
);

create view my_transaction as
  select transaction.*
    from transaction, user
   where username_mysql = SUBSTRING_INDEX(USER(),'@',1)
     and transaction.user_id = user.user_id;

CREATE TABLE service (
  service_id integer auto_increment,
  name varchar(50),
  description varchar(1000),
  bill_period enum('once','month','year'),
  bill_amount float,
  PRIMARY KEY (service_id)
);

INSERT INTO `service` VALUES
  (1,'Basic',NULL,'month',-2),
  (2,'Domain Registration',NULL,'year',-8.5);

CREATE TABLE service_detail (
  `service_detail_id` int(11) NOT NULL auto_increment,
  `service_id` int(11) default NULL,
  `name` varchar(100) default NULL,
  `is_required` enum('YES','NO') NOT NULL default 'NO',
  `type` enum('text','time','bool','number') default NULL,
  `default_value` varchar(100) default NULL,
  PRIMARY KEY  (`service_detail_id`)
);

INSERT INTO `service_detail` VALUES
  (1,1,'username','YES','text',NULL),
  (2,1,'Real Name','NO','text',NULL),
  (3,1,'shell.host','YES','text','mirabel'),
  (4,2,'Domain Name','YES','text',NULL),
  (5,2,'is_subdomain','YES','bool','0'),
  (6,2,'is_shared','YES','bool','0'),
  (7,2,'auto_renew','YES','bool','1'),
  (8,1,'email.host','YES','text','nightshade');

CREATE TABLE `subscription` (
  `subscription_id` int(11) NOT NULL auto_increment,
  `service_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `start_time` datetime default NULL,
  `end_time` datetime default NULL,
  `last_bill_time` datetime default NULL,
  PRIMARY KEY  (`subscription_id`)
);

CREATE TABLE `subscription_detail` (
  `subscription_detail_id` int(11) NOT NULL auto_increment,
  `subscription_id` int(11) default NULL,
  `service_detail_id` int(11) default NULL,
  `value` varchar(100) default NULL,
  PRIMARY KEY  (`subscription_detail_id`)
);


