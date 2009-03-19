#!/usr/bin/perl

use strict;
use lib '../lib';
use DBI;
use EPFarms::DB;
use EPFarms::User;
use EPFarms::Transaction;
use EPFarms::Service::Basic;

    require DateTime::Format::DateManip;
    sub to_dt {
      return DateTime::Format::DateManip->parse_datetime(shift)
    }

print "Enter password: ";
my $passwd = <>;
chomp $passwd;
exit unless $passwd;

my $all_users = [];

my $mysql = DBI->connect('DBI:mysql:database=epfarms_effin_effin','root',$passwd);

my $db = EPFarms::DB->new;

my $users = $mysql->selectall_arrayref(qq{ SELECT * FROM users }, {Slice => {}});
foreach my $db_user (@$users) {
  print "Processing user '$db_user->{usr_nname}'\n";
  my $user = EPFarms::User->new(
    username => $db_user->{usr_nname},
    name => $db_user->{usr_name} || '',
    mysql_username => $db_user->{usr_mysql_username} || '',
    external_email => $db_user->{usr_external_email} || '',
    unixid => $db_user->{usr_efid},
    contact => $db_user->{usr_contact} || '',
  );
  my $basic_service = EPFarms::Service::Basic->new;
  $user->add_service($basic_service);
  $db->add_user($user);
}

my $transactions = $mysql->selectall_arrayref(
  qq{ SELECT * FROM transactions}, {Slice => {}});
foreach my $db_txn (@$transactions) {
  print "Processing transaction, unixid: $db_txn->{trn_usr_efid} date: $db_txn->{trn_date} amount: $db_txn->{trn_amount}\n";
  my $user = $db->find_user(unixid => $db_txn->{trn_usr_efid});
  if(!$user) {
    die "Couldn't find user with unixid $db_txn->{trn_usr_efid}";
  }
  print "  found username: " . $user->username . "\n";
  my $transaction = EPFarms::Transaction->new(
    timestamp => to_dt($db_txn->{trn_date}),
    amount => $db_txn->{trn_amount},
    description => $db_txn->{trn_memo},
    reference_number => $db_txn->{trn_tranid} || '',
    user => $user,
    # service
  );
  $user->add_transaction($transaction);
}

print "Saving database...\n";
$db->save;

print "done!\n";

