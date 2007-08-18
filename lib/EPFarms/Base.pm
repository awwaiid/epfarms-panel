package EPFarms::Base;

use strict;
use DOMTemplate;

sub new { 
  my $proto = shift;
  my $class = ref($proto) || $proto;
  my $self = {@_};
  bless $self, $class;
  return $self;
}


1;

