
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "File::Find" => 0,
    "File::Temp" => 0,
    "Module::Build" => "0.3601",
    "Test::More" => "0.82",
    "Test::Output" => 0
  },
  "configure_requires" => {
    "ExtUtils::MakeMaker" => "6.30",
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "application for pasting to and reading from sprunge.us",
  "dist_author" => [
    "Mike Doherty <doherty\@cpan.org>"
  ],
  "dist_name" => "App-Pastebin-sprunge",
  "dist_version" => "0.008",
  "license" => "perl",
  "module_name" => "App::Pastebin::sprunge",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Getopt::Long" => 0,
    "Pod::Usage" => 0,
    "WWW::Pastebin::Sprunge::Create" => 0,
    "WWW::Pastebin::Sprunge::Retrieve" => 0,
    "perl" => "v5.10.1",
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => [
    "bin/sprunge"
  ]
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
