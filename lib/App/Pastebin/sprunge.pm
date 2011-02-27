package App::Pastebin::sprunge;
# ABSTRACT: application class for pasting to and reading from sprunge.us
# VERSION
use perl5i::2;

=head1 SYNOPSIS

    use App::Pastebin::sprunge;
    my $app = App::Pastebin::sprunge->new();
    $app->run();

=head1 DESCRIPTION

B<App::Pastebin::sprunge> provides an application interface to L<WWW::Pastebin::Sprunge::Create>
and L<WWW::Pastebin::Sprunge::Retrieve>, which allow creating and retrieving
pastes on the L<http://sprunge.us> pastebin.

This distribution provides an executable L<sprunge>, which provides a simple command-line
client for L<http://sprunge.us> using this library.

=head1 METHODS

=head2 new

B<new()> is the constructor, and creates an application object. Takes no parameters.

=cut

method new ($class:) {
    return bless {}, $class;
}

=head2 run

B<run()> runs the application.

Takes two optional parameters:

=head3 Options

The first is an options hash reference:

=over 4

=item *

If I<version> is present, the application will print out version information and exit.

=item *

If I<lang> is present, the application will append this to the returned URI.
L<http://sprunge.us> uses L<Pygments|http://pygments.org> for syntax highlighting.
In the future, there might be a check that the supplied syntax highlighter is one
supported by Pygments.

=back

=head3 Arguments

The second parameter is an array reference. Only the first element is used. It
is either the URI to a paste to read, or the ID portion of the URI (the query
string). If this is present, the application will read and print out the specified
paste.

=cut

method run($lang) {
    if (!@ARGV) {           # WRITE
        require WWW::Pastebin::Sprunge::Create;
        my $writer = WWW::Pastebin::Sprunge::Create->new();
        my $text = do { local $/; <STDIN> };
        $writer->paste($text, lang => $lang)
            or warn "Paste failed: " . $writer->error() . "\n"
            and exit 1;
        say $writer;
    }
    else {                  # READ
        my $paste_id = shift @ARGV;
        require WWW::Pastebin::Sprunge::Retrieve;
        my $reader = WWW::Pastebin::Sprunge::Retrieve->new();
        $reader->retrieve($paste_id)
            or warn "Reading paste $paste_id failed: " . $reader->error() . "\n"
            and exit 1;
        print "$reader\n";
    }
}
