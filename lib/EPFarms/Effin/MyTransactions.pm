package EPFarms::Effin::MyTransactions;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("my_transactions");
__PACKAGE__->add_columns(
  "trn_usr_efid",
  { data_type => "INT", default_value => "", is_nullable => 0, size => 11 },
  "trn_met_uid",
  { data_type => "INT", default_value => "", is_nullable => 0, size => 11 },
  "trn_date",
  { data_type => "DATETIME", default_value => "", is_nullable => 0, size => 19 },
  "trn_amount",
  { data_type => "FLOAT", default_value => 0, is_nullable => 0, size => 32 },
  "trn_acc_uid",
  { data_type => "INT", default_value => "", is_nullable => 0, size => 11 },
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
  { data_type => "INT", default_value => "", is_nullable => 0, size => 11 },
  "trn_deleted",
  { data_type => "TINYINT", default_value => 0, is_nullable => 0, size => 1 },
  "trn_createdon",
  { data_type => "DATETIME", default_value => "", is_nullable => 0, size => 19 },
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
  { data_type => "INT", default_value => 0, is_nullable => 0, size => 11 },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-26 12:36:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:AJPuBCtsJktXnbtuihmnpA

# You can replace this text with custom content, and it will be preserved on regeneration
1;
