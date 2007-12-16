#!/usr/bin/perl

package EPFarms::DB;
use base 'DBIx::Class::Schema::Loader';

package main;

EPFarms::DB->dump_to_dir('../lib');
EPFarms::DB->connection('dbi:mysql:database=epfarms', 'root', 'sulipafude');

