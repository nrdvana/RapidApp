package RapidApp::Sugar;

use strict;
use warnings;
use Exporter qw( import );
use Data::Dumper;
use RapidApp::JSON::MixedEncoder;
use RapidApp::JSON::RawJavascript;
use RapidApp::Error::UserError;
use RapidApp::Handler;

our @EXPORT = qw(sessvar perreq asjson rawjs usererr);

# Module shortcuts
#

# a per-session variable, dynamically loaded form the session object on each request
sub sessvar {
	my ($name, %attrs)= @_;
	push @{$attrs{traits}}, 'RapidApp::Role::SessionVar';
	return ( $name, %attrs );
}

# a per-request variable, reset to default or cleared at the end of each request execution
sub perreq {
	my ($name, %attrs)= @_;
	push @{$attrs{traits}}, 'RapidApp::Role::PerRequestVar';
	return ( $name, %attrs );
}

# JSON shortcuts
#

sub asjson {
	scalar(@_) == 1 or die "Expected single argument";
	return RapidApp::JSON::MixedEncoder::encode_json($_[0]);
}

sub rawjs {
	scalar(@_) == 1 && ref $_[0] eq '' or die "Expected single string argument";
	return RapidApp::JSON::RawJavascript->new(js=>$_[0]);
}

# Exception constructors

sub usererr {
	return RapidApp::Error::UserError->new(@_);
}

1;