package MooseX::MetaDescription::Meta::Attribute::Ordered;
use Moose;

our $VERSION   = '0.01';
our $AUTHORITY = 'cpan:AWWAIID';

# Global order count!
our $order = 0;

extends 'MooseX::MetaDescription::Meta::Attribute';

has 'order' => (
  is => 'ro',
  isa => 'Num',
  default => sub { $order++ }
);

no Moose; 1;

1;

