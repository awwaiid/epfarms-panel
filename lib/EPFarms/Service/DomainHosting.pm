package EPFarms::Service::DomainHosting;

use Moose;
use Moose::Util::TypeConstraints;
extends 'EPFarms::Service';

has '+service_name' => ( default => 'Domain Hosting' );
has '+bill_period' => ( default => 'once' );
has '+bill_amount' => ( default => 0 );

has domain_name => (
  is => 'rw',
  required => 1,
  isa => 'Str',
);

enum Host => ( '', 'mirabel', 'nightshade' );

has is_listed       => ( is => 'rw', isa => 'Bool' );
has is_shared       => ( is => 'rw', isa => 'Bool' );
has is_subdomain    => ( is => 'rw', isa => 'Bool' );
has service_secdns  => ( is => 'rw', isa => 'Bool' );
has service_secmail => ( is => 'rw', isa => 'Bool' );

has service_redirmail => ( is => 'rw', isa => 'Str' );

has host_dns      => ( is => 'rw', isa => 'Host' );
has host_ip       => ( is => 'rw', isa => 'Str' );
has host_mail     => ( is => 'rw', isa => 'Host' );
has host_main     => ( is => 'rw', isa => 'Host' );
has host_mysql    => ( is => 'rw', isa => 'Host' );
has host_redirect => ( is => 'rw', isa => 'Str' );
has host_site     => ( is => 'rw', isa => 'Host' );
has host_sslip    => ( is => 'rw', isa => 'Str' );
has host_sslredir => ( is => 'rw', isa => 'Str' );
has host_web      => ( is => 'rw', isa => 'Host' );

1;

