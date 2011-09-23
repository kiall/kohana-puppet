class website::forum inherits website
{
	$mysql_hostname = extlookup("forum_mysql_hostname", "127.0.0.1")
	$mysql_port     = extlookup("forum_mysql_port",     "3306")
	$mysql_database = extlookup("forum_mysql_database", "forum.kohanaframework.org")
	$mysql_username = extlookup("forum_mysql_username", "forum.kohanaframework.org")
	$mysql_password = extlookup("forum_mysql_password", false)

	$mysql_admin_password = extlookup("mysql_root_password", false, "fqdn_${mysql_hostname}")

	# Setup a Vanilla based site
	nginx::template::vanilla {
		"forum.kohanaframework.org":
			ensure   => present,
			fpm_port => 9002;
	}

	# Setup the vanilla database
	database {
		$mysql_database:
			ensure         => present,
			provider       => mysql,
			admin_username => "root",
			admin_password => $mysql_admin_password,
			hostname       => $mysql_hostname,
			port           => $mysql_port;
	}

#	database_user {
#		$mysql_username:
#			ensure         => present,
#			provider       => mysql,
#			admin_username => "root",
#			admin_password => $mysql_admin_password,
#			hostname       => $mysql_hostname,
#			port           => $mysql_port;
#	}

#	database_grant {
#		$mysql_username:
#			ensure         => present,
#			provider       => mysql,
#			admin_username => "root",
#			admin_password => $mysql_admin_password,
#			hostname       => $mysql_hostname,
#			port           => $mysql_port,
#			databases      => [$mysql_database];
#	}
}
