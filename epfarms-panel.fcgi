#!/usr/bin/perl

# This is just a wrapper script to get things started

use strict;

my $process_user = getpwuid($<);

BEGIN { chdir 'EPFarms-Panel' if -d 'EPFarms-Panel' }
use lib 'lib';
use Continuity;
use Continuity::Adapt::FCGI;
use EPFarms::Panel;

use vars qw( $run_mode $server );

use Coro;
use Coro::Event;

# If this file is changed, restart the server
async {
    my $timer = Coro::Event->timer( interval => 10, );
    my $mod_time = -M __FILE__;
    while(1) {
        $timer->next;
        if(-M __FILE__ != $mod_time) {
            STDERR->print("Exec-ing self!\n\n");
            system '/usr/bin/perl', '-c', __FILE__ and do { $mod_time = -M __FILE__; next; };
            exec '/usr/bin/perl', __FILE__;
        }
    }
};

if($ARGV[0] eq '-d') {
  # Debugging / Development server, running outside of FastCGI
  $run_mode = 'webdev';
  $server = Continuity->new(
    port => 8080,
    cookie_session => 0,
    query_session => 'sid',
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
  open STDERR, ">>", "/tmp/epfarms-panel-log-$process_user.txt";
  $server = Continuity->new(
    adaptor => Continuity::Adapt::FCGI->new,
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
}


