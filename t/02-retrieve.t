use strict;
use warnings;
use Test::More 0.82 tests => 1;
use Test::Output;
use App::Pastebin::sprunge;

BEGIN {
    @ARGV = qw(SCLg);
}
my $CONTENT = "ohaithar\n\n";

stdout_is(
    sub { App::Pastebin::sprunge->new()->run() },
    $CONTENT,
    'Paste retrieved - and done correctly'
);
