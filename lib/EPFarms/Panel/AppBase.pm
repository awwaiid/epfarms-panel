package EPFarms::Panel::AppBase;

use strict;
use base 'EPFarms::Panel::Base';

sub display {
  my ($self, $content) = @_;
  my $request = $self->{request};
  my $page = $self->{panel}->{mainpage}->clone;
  $page->set('#sid' => $request->session_id);
  $page->set('#content' => $content);
  #print STDERR "PAGE: " . ($page->as_HTML) . "\n\n";
  $self->output($page->as_HTML);
  #$request->send_header("Refresh: 0; url=/blah");
  $request->next;
}

1;

