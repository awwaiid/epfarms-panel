package EPFarms::Panel::Base;

use strict;
use Moose;

extends 'EPFarms::Base';

has 'request' => (is => 'rw');

sub param {
  my ($self, $v) = @_;
  return $self->request->param($v);
}

=head2 C<< $panel->output($html) >>

Send a whole page of output to the browser.

TODO: Send and receive a RequestID, so that we can detect the 'back' button.

=cut

sub disp {
  my ($self, $page) = @_;
  $self->request->print($page);
  $self->request->next;
}

sub get_action {
  my ($self) = @_;

  my $action = $self->param('action');
  $action =~ s/^\/// if $action;
  return $action if $action;

  my $url = $self->request->{request}->url->path;
  if($url =~ /\/(\w+)$/ && $1 ne 'epfarms-panel') {
    return $1;
  }
  return undef;
}


1;
