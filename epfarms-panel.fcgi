#!/usr/bin/perl

# This is just a wrapper script to get things started

use strict;
use lib 'lib';
use everywhere 'MooseX::Declare',
  matching => '^EPFarms';

use Continuity;
use Continuity::Adapt::FCGI;
use EPFarms::Panel;

use vars qw( $run_mode $server );

$SIG{TERM} = sub {
  exit;
};

if($ARGV[0] eq '-d') {
  # Debugging / Development server, running outside of FastCGI
  $run_mode = 'webdev';
  $server = Continuity->new(
    port => $ARGV[1] || 8080,
    cookie_session => 0,
    query_session => 'sid',
  );
} else {
  # Default to FastCGI web mode
  $run_mode = 'web';
  open STDERR, ">>", "/tmp/epfarms-panel-log.txt";
  $server = Continuity->new(
    adapter => 'FCGI',
    cookie_session => 0,
    query_session => 'sid',
  );
}

# Start the server
$server->loop;

sub main {
  my $request = shift;
  my $panel = EPFarms::Panel->new(run_mode => $run_mode, request => $request);
  eval {
    $panel->main;
  };
  if($@) {
    $request->print("Fatal Error: $@");
    $request->print("Restarting application...");
  }
  $request->end_request;
}

END {
  print STDERR "THIS IS THE END!\n";
}

