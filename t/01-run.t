use strict;
use warnings;
use Test::More tests => 2;
use App::sprunge;

my $app = new_ok('App::sprunge');
can_ok($app, qw(new run));
