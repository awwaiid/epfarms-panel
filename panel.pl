#!/usr/bin/perl

# This is just a wrapper script to get things started

use strict;
use lib 'lib';
use Continuity;
use Continuity::Adapt::FCGI;
use EPFarms::Panel;

use vars qw( $run_mode $server );

if($ARGV[0] eq '-d') {
  # Debugging / Development server, running outside of FastCGI
  $run_mode = 'webdev';
  $server = Continuity->new(
    port => 8080,
  );
} elsif($ARGV[0] eq '-s') {
  # Interactive shell
  $run_mode = 'shell';
  $server = Continuity->new(
    adaptor => Continuity::Adapt::ReadLine->new,
  );
} else {
  # Default to FastCGI web mode
  $run_mode = 'web';
  $server = Continuity->new(
    adaptor => Continuity::Adapt::FCGI->new,
  );
}

# Start the server
$server->loop;

sub main {
  my $request = shift;
  my $panel = EPFarms::Panel->new(run_mode => $run_mode, request => $request);
  $panel->main;
}


