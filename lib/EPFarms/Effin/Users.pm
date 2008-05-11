package EPFarms::Effin::Users;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("users");
__PACKAGE__->add_columns(
  "usr_efid",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "usr_nname",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "usr_contact",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "usr_isadmin",
  { data_type => "VARCHAR", default_value => undef, is_nullable => 1, size => 1 },
  "usr_deleted",
  { data_type => "BIT", default_value => undef, is_nullable => 1, size => undef },
  "usr_createdon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "usr_alteredon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "usr_deletedon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "usr_uid",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "usr_mysql_username",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "usr_external_email",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "usr_name",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
);
__PACKAGE__->set_primary_key("usr_uid");


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-10 21:30:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:CJLJldzrAmQo2E98kdLUzw

__PACKAGE__->set_primary_key("usr_efid");
__PACKAGE__->has_many('transactions', 'EPFarms::Effin::Transactions', 'trn_usr_efid');

sub balance {
  my ($self) = @_;
  my $total = 0;
  foreach my $txn ($self->transactions) {
    $total += $txn->trn_amount;
  }
  return $total;
}

sub balance_formatted {
  my ($self) = @_;
  my $balance = $self->balance;
  return sprintf('$%.02f', $balance);
}
    

1;
