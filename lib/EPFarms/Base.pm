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

sub define_accessors {
  my ($class, @names) = @_;
  no strict qw/refs/;
  foreach my $name (@names) {
    *{$class.'::'.$name} = sub { $_[0]->{$name} = $_[1] if $_[1]; $_[0]->{$name}};
  }
}


1;

