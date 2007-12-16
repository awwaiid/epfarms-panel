package EPFarms::DB::User;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("user");
__PACKAGE__->add_columns(
  "user_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "unixid",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "username",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "fullname",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
  "contact",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
);
__PACKAGE__->set_primary_key("user_id");


# Created by DBIx::Class::Schema::Loader v0.04003 @ 2007-12-08 23:37:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6Qus1niKbkE3j/Y5tWxVpA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
