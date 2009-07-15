use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'HTTP::DAV::Browse',
    license             => 'perl',
    dist_author         => 'Jozef Kutej <jkutej@cpan.org>',
    dist_version_from   => 'lib/HTTP/DAV/Browse.pm',
    requires => {
        'Moose'     => 0,
        'Moose::Util::TypeConstraints'
                    => 0,
        'MooseX::StrictConstructor'
                    => 0,
        'HTTP::DAV' => 0.38,
        'URI'       => 0,
    },
    build_requires => {
        'Test::More'      => 0,
        'Test::Exception' => 0,
        'LWP::UserAgent'  => 0,
    },
    script_files => [
    ],
    add_to_cleanup      => [ 'HTTP-DAV-Browse-*' ],
    create_readme       => 1,
    sign                => 1,
);

$builder->create_build_script();
