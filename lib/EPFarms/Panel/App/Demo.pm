package EPFarms::Panel::App::Demo;

use strict;
use Moose;
extends 'EPFarms::Panel::App';

has '+config' => (default => sub {{
  rank => '99',
  name => 'demo',
  title => 'Demo',
  icon => 'img/famfam/icons/script.png',
}});

sub main {
  my ($self) = @_;
  $self->display(qq{
    This is a demo!<br>
    Use this as a template for your own panel app!<br>
    Enter your name: <input type=text name=name>
    <input type=submit>
  });
  my $name = $self->param('name');
  $self->display("Hello, $name!\n");
}

1;

