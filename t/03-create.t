use strict;
use Test::More 0.82 tests => 1;
use Test::Output;
use IO::Socket::INET;
use App::Pastebin::sprunge;

BEGIN {
    $^W = 0; # Disable warnings because HTTP::Request::Common warns spuriously
    *STDIN = *DATA; # Fake out the library being tested - how sneaky!
    @ARGV = ();
}
use warnings;

my $sock = IO::Socket::INET->new(
    PeerHost => 'sprunge.us',
    PeerPort => 80,
    Timeout  => 5,
    Type     => SOCK_STREAM,
);
SKIP: {
    skip("Couldn't connect to sprunge.us: $!", 1)
        unless defined $sock;

    stdout_like(
        sub { App::Pastebin::sprunge->new()->run() },
        qr{http://sprunge.us/[a-zA-Z]+},
        'Paste created - and done correctly'
    );
}

__DATA__
text
more text
