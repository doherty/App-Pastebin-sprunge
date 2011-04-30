use strict;
use warnings;
use Test::More 0.82 tests => 1;
use Test::Output;
use App::Pastebin::sprunge;

BEGIN {
    @ARGV = qw(SCLg);
}

stdout_like(
    sub { App::Pastebin::sprunge->new()->run() },
    qr/ohaithar/,
    'Paste retrieved - and done correctly'
);
