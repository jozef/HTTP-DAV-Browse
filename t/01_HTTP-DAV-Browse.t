#!/usr/bin/perl

use strict;
use warnings;

#use Test::More 'no_plan';
use Test::More tests => 5;
#use Test::Differences;
use Test::Exception;
use LWP::UserAgent;

use FindBin qw($Bin);
use lib "$Bin/lib";

BEGIN {
    use_ok ( 'HTTP::DAV::Browse' ) or exit;
}

exit main();

sub main {
    my $url = 'http://svn.comsultia.com/svgraph/trunk/';
    my $browser = HTTP::DAV::Browse->new('base_uri' => $url);
    isa_ok($browser, 'HTTP::DAV::Browse');
    
    my $ua = LWP::UserAgent->new;
    $ua->timeout(1);
    $ua->env_proxy;
    my $response = $ua->get($url);
    
    SKIP: {
        skip 'no internet connection, bad luck today', 3
            if not $response->is_success;

        my @lsd = $browser->ls_detailed('');
        my ($svgraph) = grep {$_->{'rel_uri'} eq 'SVGraph/'} @lsd;
        $svgraph ||= {};
        is($svgraph->{'rel_uri'}, 'SVGraph/', 'trunk should have "SVGraph/" folder');
        cmp_ok($svgraph->{'version-name'},'>=', 69, 'revision should be >= 69');
        
        dies_ok { $browser->ls('/non-existing') } 'throw excepetion for non-existing paths';
    }
    
    return 0;
}

