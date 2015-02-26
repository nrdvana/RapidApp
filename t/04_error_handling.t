# -*- perl -*-

use strict;
use warnings;
use FindBin '$Bin';
use lib "$Bin/var/testapps/TestRA-ChinookDemo/lib";

use RapidApp::Test::EnvUtil;
BEGIN { $ENV{TMPDIR} or RapidApp::Test::EnvUtil::set_tmpdir_env() }

use Test::More;
use Test::HTML::Content;

use RapidApp::Test 'TestRA::ChinookDemo';

subtest user_facing_errors => sub {
  my $decoded = client->ajax_post_decode(
    '/errorgen/cause_usererr',
    [ usererr_argument => 'fubar' ]
  );
  
  my $headers= client->last_response->headers;
  is( $headers->header('x-rapidapp-exception'), 1, 'special rapidapp header flag' );
  is( $decoded->{msg}, 'fubar', 'Message returned to client' );
  is( $decoded->{title}, 'Error', 'Default message title' );
  done_testing;
};

done_testing;