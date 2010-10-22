use strict;
use warnings;
use Test::More 0.82 tests => 2;
use App::Pastebin::sprunge;

my $app = new_ok('App::Pastebin::sprunge');
can_ok($app, qw(new run));
