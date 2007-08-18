package EPFarms::Panel::AppBase;

use strict;
use base 'EPFarms::Panel::Base';

sub display {
  my ($self, $content) = @_;
  my $page = DOMTemplate->new('tpl/with-sidebar.html');
  $page->set_value_by_selector('#sid' => $self->{request}->session_id);
  $page->set('content' => $content);
  print STDERR "PAGE: " . ($page->as_HTML) . "\n\n";
  $self->output($page->as_HTML);
  $self->{request}->send_header("Refresh: 0; url=/blah");
  $self->{request}->next;
}

1;

