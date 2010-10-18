use strict;
use warnings;
use Test::More tests => 2;
use App::Pastebin::sprunge;

my $app = new_ok('App::Pastebin::sprunge');
can_ok($app, qw(new run));
