package EPFarms::Panel::Base;

use strict;

use lib '/home/awwaiid/projects/perl/domt';
use base 'EPFarms::Base';

sub param {
  my ($self, $v) = @_;
  return $self->{request}->param($v);
}

=head2 C<< $panel->output($html) >>

Send a whole page of output to the browser.

TODO: Send and receive a RequestID, so that we can detect the 'back' button.

=cut

sub output {
  my ($self, $page) = @_;
  $self->{request}->print($page);
  $self->{request}->next;
}

1;
