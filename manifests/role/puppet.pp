class role::puppet inherits role
{
	package {
		[
			puppetmaster,
			rails,           # Storedconfig support
			libsqlite3-ruby, # Storedconfig support
		]:
			ensure => installed;
	}

	# Setup the puppet database
#	$mysql_hostname = extlookup("puppet_mysql_hostname", "127.0.0.1")
#	$mysql_port     = extlookup("puppet_mysql_port",     "3306")
#	$mysql_database = extlookup("puppet_mysql_database", "puppet.kohanaframework.org")
#	$mysql_username = extlookup("puppet_mysql_username", "puppet.kohanaframework.org")
#	$mysql_password = extlookup("puppet_mysql_password", false)
#
#	$mysql_admin_password = extlookup("mysql_root_password", false, "fqdn_${mysql_hostname}")
#
#	database {
#		$mysql_database:
#			ensure         => present,
#			provider       => mysql,
#			admin_username => "root",
#			admin_password => $mysql_admin_password,
#			hostname       => $mysql_hostname,
#			port           => $mysql_port;
#	}
}
