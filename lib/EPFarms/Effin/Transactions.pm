package EPFarms::Effin::Transactions;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("transactions");
__PACKAGE__->add_columns(
  "trn_usr_efid",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "trn_met_uid",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "trn_date",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 0,
    size => 19,
  },
  "trn_amount",
  { data_type => "FLOAT", default_value => 0, is_nullable => 0, size => 32 },
  "trn_acc_uid",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "trn_tranid",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "trn_memo",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 1000,
  },
  "trn_sub_uid",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "trn_deleted",
  { data_type => "TINYINT", default_value => 0, is_nullable => 0, size => 1 },
  "trn_createdon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 0,
    size => 19,
  },
  "trn_alteredon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "trn_deletedon",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "trn_uid",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
);
__PACKAGE__->set_primary_key("trn_uid");


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-10 21:30:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Nykr/Pl7JlqmcsJEhYw5vg

# __PACKAGE__->belongs_to('trn_usr_efid', 'EPFarms::Effin::Users', 'usr_efid');

#__PACKAGE__->load_components("InflateColumn::DateTime");

sub trn_amount_formatted {
  my ($self) = @_;
  my $amount = $self->trn_amount;
  return sprintf('$%.02f', $amount);
}

# You can replace this text with custom content, and it will be preserved on regeneration
1;
