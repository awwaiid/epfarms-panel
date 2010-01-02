#!/usr/local/bin/perl

use 5.010;
use strict;
# use lib '/home/awwaiid/tmp/rs/PERL_CoreKIT_v3_16/cgi-bin';
# use lib '/home/awwaiid/tmp/rs/PERL_DomainsKIT_v3_16/cgi-bin';
# use lib 'lib';
use lib '../lib';
#use lib '../lib/ResellerClub/core';
use EPFarms;
#use SOAP::Lite +trace => qw( debug );
use SOAP::Lite;
use ResellerClub;
use ResellerClub::FundService;
use ResellerClub::DomOrderService;
use ResellerClub::OrderService;
use DateTime;
use Data::Dumper;

use vars qw( $username $password );
do "/home/awwaiid/.epfarms-panel/resellerclub.conf";

sub get_domain_order_id {
  my $domain_name = shift;
  my $productkey = shift;
  if(!$productkey) {
    given($domain_name) {
      when (/\.org$/) { $productkey = 'domorg' }
      when (/\.com$/) { $productkey = 'domcmo' }
      when (/\.net$/) { $productkey = 'domtin' }
    }
  }
  my $order_id = ResellerClub::DomOrderService::getOrderIdByDomain(
    @ResellerClub::std_params,
    $domain_name, # java.lang.String domainName,
    $productkey, # java.lang.String productkey
  );
}

sub get_order_actions {
  my $entityId = shift;
  my $reccount = 0;
  my $totalrecs = 0;
  my $recs = [];
  my $curpage = 1;
  my $service = ResellerClub::OrderService->new;
  $service->readable(1);

  do {
    #my $out = ResellerClub::OrderService::listArchivedActions(
    my $out = $service->listArchivedActions(
      @ResellerClub::std_params,
      [], # int[] eaqId,
      [$entityId], # int[] entityId,
      [], # int[] entitytypeid,
      [], # java.lang.String[] actionStatus,
      ['AddNewDomain','RenewDomain'], # java.lang.String[] actionType,
      10, # numOfRecordPerPage
      $curpage++, # pageNum
      '', # orderBy
    );

    my $data = ResellerClub::result_to_hash($out);
    $reccount += $data->{recsonpage};
    delete $data->{recsonpage};
    $totalrecs = $data->{recsindb};
    delete $data->{recsindb};

    push @$recs, values %$data;
    print "Recs: " . (scalar @$recs) . "\n";
  } while($reccount < $totalrecs);
  return $recs;
}


sub get_all_orders {
  # my $dom_order = ResellerClub::DomOrderService->new;
  # $dom_order->readable(1);

  my $reccount = 0;
  my $totalrecs = 0;
  my $recs = [];

  my $curpage = 1;
  my $fromDate = DateTime->new( year => 2000 )->epoch;
  my $toDate   = DateTime->now->epoch;
  print STDERR "From: $fromDate\nTo: $toDate\n";

  do {

    my $out = ResellerClub::FundService::listCustomerTransactions(
      $username, # userName
      $password, # password
      #'awwaiid@thelackthereof.org', # #userName
      #'awwaiid42', # #password
      'reseller', # role
      'en', # langpref
      1, # parentid
      '', # int[] customerId,
      '', # java.lang.String[] customerUserName,
      '', # java.lang.String[] type,
      '', # java.lang.String key,
      '', # int[] typeId,
      '', # int[] transId,
      '', # java.lang.String balanceType,
      '', # java.lang.String description,
      '', # java.lang.String amountStartRange,
      '', # java.lang.String amountEndRange,
      $fromDate, # java.lang.String fromDate,
      $toDate, # java.lang.String toDate,
      100, # int numOfRecordPerPage,
      $curpage++, # int pageNum,
      '', # java.lang.String[] orderBy
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

# use lib::Order;
# my $order = Order->new();
# $order->wsdlURL('file:///home/awwaiid/projects/perl/EPFarms-Panel/lib/ResellerClub/core/lib/wsdl/Order.wsdl');
# $order->StartServices();
# $order->listArchivedActions(
      # @ResellerClub::std_params,
      # '', # int[] eaqId,
      # [778561], # int[] entityId,
      # '', # int[] entitytypeid,
      # '', # java.lang.String[] actionStatus,
      # ['AddNewDomain','RenewDomain'], # java.lang.String[] actionType,
      # 10, # numOfRecordPerPage
      # 1, # pageNum
      # '', # orderBy
    # );
# my $result = $order->result;
# print "Result: " . Dumper($result);
# my $val = $order->printComplexType( $result );
# print "Val: " . Dumper($val);
# exit;



my $order_id = get_domain_order_id('thelackthereof.org');
print "Order ID: $order_id\n";
print "\n\n\n\n\n";
#my $order_id = 778561;
my $actions = get_order_actions($order_id);
print "Actions: " . Dumper($actions);

exit;

my $recs = get_all_orders;
print Dumper($recs);

print "Record count: " . (scalar @$recs) . "\n";
exit;

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

__END__
POST /anacreon/servlet/APIv3-XML
HTTP/1.0
User-Agent: NuSOAP/0.6.6
Host: demo.myorderbox.com:80
Content-Type: text/xml; charset=UTF-8
SOAPAction: ""
Content-Length: 1593 

<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:si="http://soapinterop.org/xsd" xmlns:impl="com.logicboxes.foundation.sfnb.order.Order">
<SOAP-ENV:Body>
<impl:listArchivedActions>
<SERVICE_USERNAME xsi:type="xsd:string">
epfarms@epfarms.org</SERVICE_USERNAME>
<SERVICE_PASSWORD xsi:type="xsd:string">
Ykuj6WGv</SERVICE_PASSWORD>
<SERVICE_ROLE xsi:type="xsd:string">
reseller</SERVICE_ROLE>
<SERVICE_LANGPREF xsi:type="xsd:string">
en</SERVICE_LANGPREF>
<SERVICE_PARENTID xsi:type="xsd:int">
1</SERVICE_PARENTID>
<eaqId xsi:type="SOAP-ENC:Array" SOAP-ENC:arrayType="xsd:int[0]">
</eaqId>
<entityId xsi:type="SOAP-ENC:Array" SOAP-ENC:arrayType="xsd:int[1]">
<item xsi:type="xsd:int">
778561</item>
</entityId>
<entitytypeid xsi:type="SOAP-ENC:Array" SOAP-ENC:arrayType="xsd:int[0]">
</entitytypeid>
<actionStatus xsi:type="SOAP-ENC:Array" SOAP-ENC:arrayType="xsd:string[0]">
</actionStatus>
<actionType xsi:type="SOAP-ENC:Array" SOAP-ENC:arrayType="xsd:string[2]">
<item xsi:type="xsd:string">
AddNewDomain</item>
<item xsi:type="xsd:string">
RenewDomain</item>
</actionType>
<numOfRecordPerPage xsi:type="xsd:int">
3</numOfRecordPerPage>
<pageNum xsi:type="xsd:int">
1</pageNum>
<orderBy xsi:type="SOAP-ENC:Array" SOAP-ENC:arrayType="xsd:string[0]">
</orderBy>
</impl:listArchivedActions>
</SOAP-ENV:Body>
</SOAP-ENV:Envelope>

