package Continuity::Widget;

use strict;
use Moose;
use Coro::Continuation;
use Data::UUID;

has 'cont' => (is => 'rw');
has 'request' => (is => 'rw');
has 'id' => (
  is      => 'ro', 
  isa     => 'Str', 
  default => sub { Data::UUID->new->create_str }
);
has 'output' => (is => 'rw',   isa => 'Str', default => '');

sub process {
  my ($self) = @_;
  $self->{cont} ||= continuation { $self->main };
  $self->{cont}->();
}

sub next {
  my ($self) = @_;
  yield;
}

1;

