use strict;
use Test::More 0.82 tests => 1;
use Test::Output;
use App::Pastebin::sprunge;

BEGIN {
    $^W = 0; # Disable warnings because HTTP::Request::Common warns spuriously
    *STDIN = *DATA; # Fake out the library being tested - how sneaky!
    @ARGV = ();
}
use warnings;

stdout_like(
    sub { App::Pastebin::sprunge->new()->run() },
    qr{http://sprunge.us/[a-zA-Z]+},
    'Paste created - and done correctly'
);

__DATA__
text
more text
