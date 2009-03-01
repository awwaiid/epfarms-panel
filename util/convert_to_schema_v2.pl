#!/usr/bin/perl

use DBI;

print "Enter password: ";
my $passwd = <>;
chomp $passwd;

my $db = DBI->connect('DBI:mysql:database=epfarms_effin_effin', 'root', $passwd);

my $users = $db->selectall_hashref(qq{ SELECT * FROM users });
foreach my $user (@$users) {
  $db->dwidoexecute(qq{
    INSERT INTO user SET
      username = ?,
      name = ?,
      external_email = ?,
      contact = ?,
      mysql_username = ?,
      unixid = ?
  }, undef,
    $user->{usr_nname},
    $user->{usr_name},
    $user->{usr_external_email},
    $user->{usr_contact},
    $user->{usr_mysql_username},
    $user->{usr_efid}
  );
}


