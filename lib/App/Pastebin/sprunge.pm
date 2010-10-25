use strict;
use warnings;
package App::Pastebin::sprunge;
# ABSTRACT: application class for pasting to and reading from sprunge.us

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

sub new {
    my $class = shift;
    my $name  = shift;

    my $self = { name => $name };
    bless($self, $class);
    return $self;
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

sub run {
    my $self = shift;
    my $opts = shift;
    my $args = shift;

    if ($opts->{'version'}) {
        require File::Basename;
        my $this = File::Basename::basename($0);
        my $this_ver = App::Pastebin::sprunge->VERSION();
        print "$this version $this_ver\n" and exit;
    }

    if (! scalar @$args) {  # WRITE
        require WWW::Pastebin::Sprunge::Create;
        require File::Slurp;
        my $writer = WWW::Pastebin::Sprunge::Create->new();
        my $text = File::Slurp::slurp(\*STDIN);
        $writer->paste($text, lang => $opts->{'lang'})
            or warn "Paste failed: " . $writer->error() . "\n"
            and exit 1;
        print "$writer\n";
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

1;

__END__
