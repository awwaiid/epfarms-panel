package EPFarms::Effin::SubscriptionDetail;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("subscription_detail");
__PACKAGE__->add_columns(
  "subscription_detail_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "subscription_id",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "service_detail_id",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "value",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 100,
  },
);
__PACKAGE__->set_primary_key("subscription_detail_id");


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-26 12:36:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Yd/6xMJ5/KvJsUI2S/xXdQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
