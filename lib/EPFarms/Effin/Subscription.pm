package EPFarms::Effin::Subscription;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("subscription");
__PACKAGE__->add_columns(
  "subscription_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "service_id",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "user_id",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "start_time",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "end_time",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
  "last_bill_time",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 1,
    size => 19,
  },
);
__PACKAGE__->set_primary_key("subscription_id");


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-26 12:36:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Lo2E/o/TPOP3TCAgs+iCCA

__PACKAGE__->has_many('details', 'EPFarms::Effin::SubscriptionDetail', 'subscription_id');
__PACKAGE__->belongs_to('service' => 'EPFarms::Effin::Service', 'service_id');

# You can replace this text with custom content, and it will be preserved on regeneration
1;
