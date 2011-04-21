package App::Pastebin::sprunge;
use perl5i::2;
# ABSTRACT: application for pasting to and reading from sprunge.us
# VERSION

=head1 SYNOPSIS

    use App::Pastebin::sprunge;
    my $app = App::Pastebin::sprunge->new();
    $app->run();

=head1 DESCRIPTION

B<App::Pastebin::sprunge> provides an application interface to
L<WWW::Pastebin::Sprunge::Create> and L<WWW::Pastebin::Sprunge::Retrieve>,
which allow creating and retrieving pastes on the L<http://sprunge.us> pastebin.

This distribution provides an executable L<sprunge>, which provides a simple
command-line client for L<http://sprunge.us> using this library.

=head1 METHODS

=head2 new

B<new()> is the constructor, and creates an application object. Takes no
parameters.

=cut

method new ($class:) {
    my $self;
    if (@ARGV) {                # READ
        $self->{paste_id} = shift @ARGV;
        require WWW::Pastebin::Sprunge::Retrieve;
        $self->{reader} = WWW::Pastebin::Sprunge::Retrieve->new();
    }
    else {                      # WRITE
        require WWW::Pastebin::Sprunge::Create;
        $self->{writer} = WWW::Pastebin::Sprunge::Create->new();
    }
    return bless $self, $class;
}

=head2 run

B<run()> runs the application.

If I<lang> is present, the application will append this to the returned URI.
L<http://sprunge.us> uses L<Pygments|http://pygments.org> for syntax
highlighting.

=cut

method run($lang) {
    if ($self->{paste_id}) {    # READ
        $self->{reader}->retrieve($self->{paste_id})
            or warn "Reading paste $self->{paste_id} failed: "
            . $self->{reader}->error() . "\n"
            and exit 1;
        say $self->{reader};
    }
    else {                      # WRITE
        my $text = do { local $/; <STDIN> };
        $self->{writer}->paste($text, lang => $lang)
            or warn 'Paste failed: '
            . $self->{writer}->error() . "\n"
            and exit 1;
        say $self->{writer};
    }
    return;
}
