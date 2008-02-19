package EPFarms::Panel::App;

use Moose;
extends qw( EPFarms::Panel::Base Continuity::Widget );

our $VERSION = '2.01';

=head1 NAME

EPFarms::Panel::App - Base class for panel applications

=head1 SYNOPSIS

  use base 'EPFarms::Panel::App';

=head1 DESCRIPTION

This base class provides both a common API for the panel applications, and some
useful helpers.

There are generally two modes for an application. REST-mode, which is generally
state-less, and Continuity-mode, which is stateful.

=head1 METHODS

=head2 C<< $panel = EPFarms::Panel::App->new(...) >>

Create a new instance of the panel application. Each user gets their own instance, though
they might be viewing the instance with several views simultaneously.

=cut

has 'panel'  => (is => 'ro');
has 'config' => (is => 'ro', default => sub {{
  rank => '50',
  name => '',
  title => '',
  icon => 'img/famfam/icons/house.png'
}});

sub display {
  my ($self, $content) = @_;
  return $self->next($content);
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

use DBI;

sub get_mysql_auth {
  my ($self) = @_;
  my $dsn = 'DBI:mysql:database=epfarms_effin_effin';
  my $username = $self->{panel}->{user}->{username};
  my $password = $self->{panel}->{user}->{password};

  # First try with what we have
  eval { DBI->connect($dsn, $username, $password, { RaiseError => 1}) };
  return ($username, $password) unless $@;

  while(1) {

    $password = `cat ~/.epfarms-panel/mysql_password`;
    chomp $password;

    # Try with the cached password
    eval { DBI->connect($dsn, $username, $password, { RaiseError => 1}) };
    return ($username, $password) unless $@;

    # Then ask for the password
    $self->display(qq|
      <p>Our default entry for your MySQL username and password failed. If you
      do not use MySQL in any web applications, you can just reset your
      password and continue.</p>
      <br>
      
      <input type=submit name="resetpassword" value="Reset MySQL Password">

      <p>If you do use your MySQL password in web applications, you might have
      set a separate MySQL password. Please enter your MySQL username and
      password, and I will remember it in the future.</p>

      <br><br>

      Username: <input type=text name=username value="$username"><br>
      Password: <input type=password name=password><br>

      <input type=submit name="authenticate" value="Authenticate to MySQL">
    |);

    if($self->param('resetpassword')) {
      `/usr/local/bin/mysql_passwd_reset -y`;
      $password = `cat ~/.epfarms-panel/mysql_password`;
      chomp $password;
      $self->display(qq{
        <p>Password reset to '$password'. You may want to keep this password in
        case you install any MySQL-based web applications, though you can
        always reset it again later.</p>
        <br><br>
        <input type=submit value=Continue>
      });
    } else {
      $username = $self->param('username');
      $password = $self->param('password');
      print STDERR "Trying MySQL User: $username\n";

      eval { DBI->connect($dsn, $username, $password, { RaiseError => 1}) };
      return ($username, $password) unless $@;

      print STDERR "Error logging in to DB: $@\n";
      $self->display(qq|
        <p>Well that didn't work either. I'm letting support know that there is a problem and they will contact you. You can try again too, if you like.</p>
        <p>(DB Error: $@)</p>
      |);
      return;
    }
  }

}

sub get_effin_db {
  my ($self) = @_;
  my ($username, $password) = $self->get_mysql_auth;
  return unless $username;
  my $db = EPFarms::Effin->connect(
    'dbi:mysql:database=epfarms_effin_effin',
    $username,
    $password
  );
  return $db;
}



=head1 SEE ALSO

L<EPFarms::Panel>, L<http://community.epfarms.org/Panel_Documentation>

=head1 AUTHOR

Brock Wilcox, E<lt>awwaiid@epfarms.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007 by Brock Wilcox

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

1;

