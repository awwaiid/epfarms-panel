package EPFarms::Effin::Users;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("users");
__PACKAGE__->add_columns(
  "usr_efid",
  { data_type => "INT", default_value => "", is_nullable => 0, size => 11 },
  "usr_fname",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "usr_lname",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
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
);
__PACKAGE__->set_primary_key("usr_uid");


# Created by DBIx::Class::Schema::Loader v0.04003 @ 2007-12-23 21:13:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7kx0Oi5ycET5Nuv57sUrKw

__PACKAGE__->set_primary_key("usr_efid");
__PACKAGE__->has_many('transactions', 'EPFarms::Effin::Transactions', 'trn_usr_efid');

1;
