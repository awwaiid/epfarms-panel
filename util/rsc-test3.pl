#!/usr/bin/perl

use strict;
use SOAP::Lite +trace => 'debug';

# Get username/password
use vars qw( $username $password );
do "/home/awwaiid/.epfarms-panel/resellerclub.conf";

my $s = SOAP::Lite->new;
$s->proxy('http://demo.myorderbox.com/anacreon/servlet/APIv3-XML');
$s->readable(1);
$s->ns('com.logicboxes.foundation.sfnb.order.DomOrder');
$s->default_ns('com.logicboxes.foundation.sfnb.order.DomOrder');
$s->call( list => {
      role => 'reseller',
      langpref => 'en',
      parentid => 1,
      orderId => '',
      resellerId => '',
      customerId => '',
      showChildOrders => '',
      classKey => '',
      currentStatus => '',
      description => '',
      ns => '',
      contactName => '',
      contactCompanyName => '',
      creationDTRangStart => '',
      creationDTRangEnd => '',
      endTimeRangStart => '',
      endTimeRangEnd => '',
      numOfRecordPerPage => 100,
      pageNum => 1,
      orderBy => '',
      }
);

