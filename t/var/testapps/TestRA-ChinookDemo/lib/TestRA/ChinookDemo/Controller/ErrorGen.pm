package # hide from PAUSE
     TestRA::ChinookDemo::Controller::ErrorGen;

use Moose;
BEGIN { extends 'Catalyst::Controller'; }

use strict;
use warnings;
use RapidApp::Util ':all';

sub cause_die :Local {
  my ($self, $c)= @_;
  die $c->req->param('die_argument');
}

sub cause_db_exception :Local {
  my ($self, $c)= @_;
  $c->model('DB::Artist')->search({ not_a_column => 5 });
}

sub cause_usererr :Local {
  my ($self, $c)= @_;
  die usererr $c->req->param('usererr_argument');
}

1;
