# Define Nodes
node "puppet.kohanaframework.org" {
	include role::puppet
#	include role::web
#	include role::mysql
#	#include role::ci
#	include role::monitor

#	include website::www
#	include website::forum
#	include website::dev
#	include website::pear
#	#include website::ci
}

node "vm01.kohanaframework.org" {
	include role::web
	include role::mysql

	include website::www
	include website::forum
	include website::pear
}

node "ci.kohanaframework.org" {
	include role::ci
}

node "server-55.novalocal" {
	include role::ci
}

node "vm03.kohanaframework.org" {
	include role::web

	include website::dev
}
