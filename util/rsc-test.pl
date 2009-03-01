#!/usr/local/bin/perl

use strict;
use lib '../lib';
use SOAP::Lite +trace => qw( debug );
use ResellerClub::DomOrderService;

use vars qw( $username $password );
do "/home/awwaiid/.epfarms-panel/resellerclub.conf";

sub get_all_orders {
  my $dom_order = ResellerClub::DomOrderService->new;
  $dom_order->readable(1);

  my $reccount = 0;
  my $totalrecs = 0;
  my $recs = [];

  my $curpage = 1;

  do {

    my $out = ResellerClub::DomOrderService::list(
      $username, # userName
      $password, # password
      #'awwaiid@thelackthereof.org', # #userName
      #'awwaiid42', # #password
      'reseller', # role
      'en', # langpref
      1, # parentid
      '', # orderId
      '', # resellerId
      '', # customerId
      0, # showChildOrders
      '', # classKey
      '', # currentStatus
      '', # description
      '', # ns
      '', # contactName
      '', # contactCompanyName
      '', # creationDTRangStart
      '', # creationDTRangEnd
      '', # endTimeRangStart
      '', # endTimeRangEnd
      100, # numOfRecordPerPage
      $curpage++, # pageNum
      '', # orderBy
    );

    # Lets just totally cheat and use a regex to turn this into a hash
    $out =~ s/^<\?xml[^>]*>//;
    $out =~ s/<Hashtable[^>]*>/{/g;
    $out =~ s/<\/Hashtable>/}\n/g;
    $out =~ s/<row name="([^"]*)">/'$1' => /g;
    $out =~ s/<\/row>/,\n/g;
    $out =~ s/ => ([^,{]+),/ => '$1',/g;

    my $data = eval $out;
    $reccount += $data->{recsonpage};
    delete $data->{recsonpage};
    $totalrecs = $data->{recsindb};
    delete $data->{recsindb};

    push @$recs, values %$data;


  } while($reccount < $totalrecs);

  return $recs;
}

my $recs = get_all_orders;
use Data::Dumper;
print Dumper($recs);

print "Record count: " . (scalar @$recs) . "\n";

my $domains = {};

foreach my $row (@$recs) {
  $domains->{$row->{'entity.description'}}->{$row->{'entity.currentstatus'}}++;
}

print "Active:\n";
my $active_count = 0;
foreach my $d (sort keys %$domains) {
  print "$d\t$domains->{$d}->{Active}\n" if $domains->{$d}->{Active};
  $active_count++ if $domains->{$d}->{Active};
}

print "Deleted:\n";
my $deleted_count = 0;
foreach my $d (sort keys %$domains) {
  print "$d\t$domains->{$d}->{Deleted}\n" if $domains->{$d}->{Deleted};
  $deleted_count++ if $domains->{$d}->{Deleted};
}

print "Active count: $active_count\n";
print "Deleted count: $deleted_count\n";


