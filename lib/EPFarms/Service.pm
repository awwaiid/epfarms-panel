package EPFarms::Service;

use Moose;
use Moose::Util::TypeConstraints;
use DateTime;

extends 'EPFarms';

has service_name => (
  is => 'ro',
  isa => 'Str',
  default => 'Generic'
);

enum TimePeriod => qw( once month year );

has bill_period => (
  is => 'rw',
  isa => 'TimePeriod',
  default => 'once',
);

has bill_amount      => ( is => 'rw', isa => 'Num', default => 0);
has start_time       => ( is => 'rw', isa => 'DateTime', default => sub { DateTime->now } );
has end_time         => ( is => 'rw', isa => 'Maybe[DateTime]', coerce => 1);
has last_billed_time => ( is => 'rw', isa => 'Maybe[DateTime]' );

class_type 'DateTime';
coerce 'DateTime'
  => from 'Str'
  => via {
    require DateTime::Format::DateManip;
    DateTime::Format::DateManip->parse_datetime($_)
  };
coerce 'Maybe[DateTime]'
  => from 'Str'
  => via {
    require DateTime::Format::DateManip;
    DateTime::Format::DateManip->parse_datetime($_)
  };

sub is_active {
  my $self = shift;
  return (!$self->end_time || $self->end_time > DateTime->now) ? 1 : 0;
}

1;

