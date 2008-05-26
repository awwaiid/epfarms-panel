#!/usr/bin/perl

use strict;
use DBI;

print "
This program will fix the permissons in the Effin DB.
";

print "Password: ";
my $password = <>;
chomp $password;

my $db = DBI->connect('DBI:mysql:database=epfarms_effin_effin', 'root', $password);

my $users = $db->selectall_arrayref("
  SELECT username
    FROM user
");
                           
foreach my $user (@$users) {
  my $username = $user->[0];
  print "Processing: $username\n";
  $db->do("grant select on epfarms_effin_effin.my_transaction to ?", undef, $username);
  $db->do("grant select on epfarms_effin_effin.my_user to ?", undef, $username);
  $db->do("
    grant update (name, contact, external_email)
       on epfarms_effin_effin.my_user
       to ?",
    undef, $username);
}
