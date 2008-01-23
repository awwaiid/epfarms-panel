package EPFarms::Panel;

use Data::Dumper;
use Moose;
extends 'EPFarms::Panel::Base';

use EPFarms::Panel::Auth;

has 'apps' => ( is => 'rw', isa => 'ArrayRef', default => sub { [] });
has 'app' => ( is => 'rw', default => sub { {} } );
has 'mainpage' => ( is => 'rw' );
has 'user' => (is => 'rw');
has 'action' => (is => 'rw', default => sub { {} });

our $VERSION = '2.01';

=head1 NAME

EPFarms::Panel - Panel application object for Eggplant Farms

=head1 SYNOPSIS

  use EPFarms::Panel;
  my $panel = EPFarms::Panel->new;

=head1 DESCRIPTION

The Eggplant Farms panel is a primary access point for Eggplant Farms
account settings and information.

The panel itself is actually a manager for a pluggable collection of
specialized applications, All under the EPFarms::Panel::App namespace.

=head1 METHODS

=head2 C<< $panel = EPFarms::Panel->new(...) >>

Create a new instance of the panel. Each user gets their own instance, though
they might be viewing the instance with several views simultaneously.


=head2 C<< $panel->main >>

Main entrypoint of panel application. This does authentication and initializes
the list of modules. There is one instance of this loop running per-user
per-window.

=cut

sub main {
  my ($self) = @_;
  my $auth = EPFarms::Panel::Auth->new(%$self);
  my $user = $auth->get_authenticated_user;
  return unless $user;

  $self->user($user);

  $self->load_apps;
  my $page = $self->load_main_page($user);

  # Main page event loop
  while(1) {

    my $action = $self->get_action || 'home';

    if($action eq 'logout') {
      $auth->logout;
      undef $auth;
      last;
    }

    if($action) {
      print STDERR "Executing app: $action\n";
      my $output = $self->app->{$action}->process;
      $self->mainpage->set('#content', $output);
      $self->disp($self->mainpage->as_HTML);
    } else {
      $self->disp("Error");
    }
  }

  $page = DOMTemplate->new('tpl/modal-dialog.html');
  $page->set('#dialog' => qq{
      <h2>You are now logged out!</h2>
      <a href="http://epfarms.org/">Return to epfarms.org</a>
      <br><br>
      <a href="./">Restart User Panel</a>
  });
  $page->set('#sid', $self->request->session_id);
  # $self->request->print($page->render);
  $self->request->print($page->as_HTML);
}

sub load_apps {
  my ($self) = @_;
  # Look up all the available apps
  my @applist = ((glob 'lib/EPFarms/Panel/App/*.pm'), (glob '~/.epfarms-panel/App/*.pm'));
  eval q|use lib "/home/" . $self->user->{username} . "/.epfarms-panel"; |;
  @applist = map {s/^(lib|.*epfarms-panel)\///g;$_} @applist;
  @applist = map {s/\.pm$//g;$_} @applist;
  @applist = map {s/\//::/g;$_} @applist;

  print STDERR "*** Loading: @applist\n";

  # Load them all (they register themselves)
  foreach my $appname (@applist) {
    eval "use $appname";
    if($@) {
      print STDERR "Error: $@\n";
    } else {
      my $app = $appname->new(panel => $self, request => $self->request);
      push @{$self->apps}, $app;
    }
  }
}

sub load_main_page {
  my ($self, $user) = @_;
  my $page = DOMTemplate->new('tpl/with-sidebar.html');
  $page->set('#sid' => $self->request->session_id);
  $page->set('.username' => $user->{username});

  my $sidebar_item_html = '';

  my @items = map  { $_->[0] }
              sort { $a->[1] cmp $b->[1] }
              map  { [ $_, ($_->config->{rank} || '50') . $_->config->{name} ] }
              @{$self->apps};

  foreach my $sidebar_item (@items) {

    print STDERR "    Found app: " . $sidebar_item->config->{name} . "\n";

    # Check to see if this user should see this app
    if($sidebar_item->config->{user_group}) {
      my $groups = (getgrnam($sidebar_item->config->{user_group}))[3];
      next unless $groups =~ /\b$user->{username}\b/;
    }

    print STDERR "  Loading app: " . $sidebar_item->config->{name} . "\n";

    $sidebar_item_html .= qq|
      <li> <a href="@{[$sidebar_item->config->{name}]}">
        <img border=0 align=top src="@{[$sidebar_item->config->{icon}]}">
        @{[$sidebar_item->config->{title}]}</a> </li>
    |;
    my $name = $sidebar_item->config->{name};
    $self->app->{$name} = $sidebar_item;
  }

  $page->set('#sidebar_apps' => $sidebar_item_html);

  $self->mainpage($page);
  return $page;
}

=head1 SEE ALSO

L<http://community.epfarms.org/Panel_Documentation>

=head1 AUTHOR

Brock Wilcox, E<lt>awwaiid@epfarms.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007 by Brock Wilcox

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

1;

