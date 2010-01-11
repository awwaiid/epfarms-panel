#!/usr/local/bin/perl

use strict;
use lib '../lib';
use SOAP::Lite;# +trace => qw( debug );
use ResellerClub;
use ResellerClub::DomOrderService;
use ResellerClub::OrderService;
use Data::Dumper;

sub get_all_orders {
  # my $dom_order = ResellerClub::DomOrderService->new;
  # $dom_order->readable(1);

  my $reccount = 0;
  my $totalrecs = 0;
  my $recs = [];

  my $curpage = 1;

  do {

    my $out = ResellerClub::DomOrderService::list(
      $username, # userName
      $password, # password
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

    my $data = ResellerClub::result_to_hash($out);
    $reccount += $data->{recsonpage};
    delete $data->{recsonpage};
    $totalrecs = $data->{recsindb};
    delete $data->{recsindb};

    push @$recs, values %$data;
  } while($reccount < $totalrecs);
  return $recs;
}

sub get_order_actions {
  my $entityId = shift;
  my $reccount = 0;
  my $totalrecs = 0;
  my $recs = [];
  my $curpage = 1;
  do {
    my $out = ResellerClub::OrderService::listArchivedActions(
      $username, # userName
      $password, # password
      'reseller', # role
      'en', # langpref
      1, # parentid
      '', # int[] eaqId,
      $entityId, # int[] entityId,
      '', # int[] entitytypeid,
      '', # java.lang.String[] actionStatus,
      '', # java.lang.String[] actionType,
      100, # numOfRecordPerPage
      $curpage++, # pageNum
      '', # orderBy
    );

    my $data = result_to_hash($out);
    $reccount += $data->{recsonpage};
    delete $data->{recsonpage};
    $totalrecs = $data->{recsindb};
    delete $data->{recsindb};

    push @$recs, values %$data;
    print "Recs: " . (scalar @$recs) . "\n";
  } while($reccount < $totalrecs);
  return $recs;
}

# my $recs = get_all_orders;
# print Dumper($recs);

# print "Record count: " . (scalar @$recs) . "\n";

# my $domains = {};

# foreach my $row (@$recs) {
  # $domains->{$row->{'entity.description'}}->{$row->{'entity.currentstatus'}}++;
# }

# print "Active:\n";
# my $active_count = 0;
# foreach my $d (sort keys %$domains) {
  # print "$d\t$domains->{$d}->{Active}\n" if $domains->{$d}->{Active};
  # $active_count++ if $domains->{$d}->{Active};
# }

# print "Deleted:\n";
# my $deleted_count = 0;
# foreach my $d (sort keys %$domains) {
  # print "$d\t$domains->{$d}->{Deleted}\n" if $domains->{$d}->{Deleted};
  # $deleted_count++ if $domains->{$d}->{Deleted};
# }

# print "Active count: $active_count\n";
# print "Deleted count: $deleted_count\n";


my $actions = get_order_actions(3968305);

print Dumper($actions);

