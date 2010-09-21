use strict;
use warnings;
use Test::More tests => 3;

BEGIN {
    use_ok('App::Sprunge');
}
use App::Sprunge;

my $app = new_ok('App::Sprunge');
can_ok($app, qw(new run));
