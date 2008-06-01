package EPFarms::Effin::UserTransaction;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("user_transaction");
__PACKAGE__->add_columns(
  "user_id",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "transaction_id",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "subscription_id",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-26 01:06:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:OrY6xxmYZdIOUU4Q62iSVw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
