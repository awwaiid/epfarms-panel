
package EPFarms::Panel::App::Account;

use strict;
use EPFarms::Panel::AppBase;
use base 'EPFarms::Panel::AppBase';

=head1 NAME

EPFarms::Panel::App::Passwd - Password Changer

=head1 DESCRIPTION

Allows users to change their password.

=head1 METHODS

=cut

sub new {
  my $class = shift;
  my $self = $class->SUPER::new(@_);

  $self->{panel}->add_sidebar_action(
    name => 'account_finance',
    title => 'Account Finances',
    icon => 'img/famfam/icons/money.png',
    code => sub { $self->show_finances }
  );

  return $self;
}

sub show_finances {
  my ($self) = @_;
  my $username = $self->{panel}->{user}->{username};
  my $tpl = DOMTemplate->new('tpl/accounting.html');
  $tpl->set('.username' => $username);
  $tpl->set('#item_name' => "Deposit for $username");
  while(1) {
    $tpl->set('#balance' => '----');
    $self->display( $tpl->render );
    my $action = $self->get_action;
    if($action ne 'account_finance') {
      return;
    }
  }
}

=head1 SEE ALSO

L<EPFarms::Panel::App>
L<EPFarms::Panel>
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


