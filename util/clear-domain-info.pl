#!/usr/bin/perl

use EPFarms;
$db = EPFarms::DB->new;
@users = $db->filter_all( sub { ref $_ eq 'EPFarms::User' } );
foreach $user (@users) {
  print $user->username . "\n" ;
  foreach $txn ($user->transactions->members) {
    if($txn->description =~ /^(Regis|Transf|Renew|Domain)/) {
    print "Removing: " . $txn->description . "\n";
    $user->transactions->remove( $txn );
    $db->db->delete($txn);
  }
  $db->db->store($user)
}

