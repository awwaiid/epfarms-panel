#!/usr/bin/perl

package EPFarms::Effin;
use base 'DBIx::Class::Schema::Loader';

EPFarms::Effin->loader_options(
  components => qw/ InflateColumn::DateTime /
);

package main;
use strict;

print "Enter password: ";
my $passwd = <>;
chomp $passwd;

EPFarms::Effin->dump_to_dir('../lib');
EPFarms::Effin->connection('dbi:mysql:database=epfarms_effin_effin', 'root', $passwd);

