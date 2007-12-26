package EPFarms::Panel::AppBase;

use Moose;
extends 'EPFarms::Panel::Base';

has 'panel' => (is => 'ro');
has 'config' => (default => {
  rank => '50',
  name => '',
  title => '',
  icon => 'img/famfam/icons/house.png'
});

sub display {
  my ($self, $content) = @_;
  my $request = $self->request;
  my $page = $self->panel->{mainpage}->clone;
  $page->set('#sid' => $request->session_id);
  $page->set('#content' => $content);
  #print STDERR "PAGE: " . ($page->as_HTML) . "\n\n";
  $self->output($page->as_HTML);
  #$request->send_header("Refresh: 0; url=/blah");
  #$request->next;
}

sub user_domains {
  my ($self) = @_;
  my $username = $self->panel->{user}->{username};
  my @domains = `ls /var/www/$username`;
  @domains = map { chomp ; $_ } @domains;
  @domains = grep { $_ !~ /
    ^(  back_to_home
      | public_html
      | tmp
      | web_logfiles
      | web_passwds
      | web_uploads
    )$/x
  } @domains;
  return @domains;
}

1;

