use strict;
use warnings;
use Test::More 0.82 tests => 1;
use Test::Output;
use IO::Socket::INET;
use App::Pastebin::sprunge;

BEGIN {
    @ARGV = qw(cQVR);
}

my $sock = IO::Socket::INET->new(
    PeerHost => 'sprunge.us',
    PeerPort => 80,
    Timeout  => 5,
    Type     => SOCK_STREAM,
);
SKIP: {
    skip("Couldn't connect to sprunge.us: $!", 1)
        unless defined $sock;
    $sock->close;

    stdout_like(
        sub { App::Pastebin::sprunge->new()->run() },
        qr/ohaithar/,
        'Paste retrieved - and done correctly'
    );
}