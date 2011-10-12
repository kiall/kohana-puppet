class website::dev inherits website
{
	$mysql_hostname = extlookup("dev_mysql_hostname", "127.0.0.1")
	$mysql_port     = extlookup("dev_mysql_port",     "3306")
	$mysql_database = extlookup("dev_mysql_database", "dev.kohanaframework.org")
	$mysql_username = extlookup("dev_mysql_username", "dev.kohanaframework.org")
	$mysql_password = extlookup("dev_mysql_password", false)

	$mysql_admin_password = extlookup("mysql_root_password", false, "fqdn_${mysql_hostname}")

	# Setup a Rails based site
	nginx::template::rails {
		"dev.kohanaframework.org":
			ensure    => present,
			thin_port => 3001,
			servers   => 3,
			rails_env => "production";
	}

	# Setup the redmine database
	database {
		$mysql_database:
			ensure         => present,
			provider       => mysql,
			admin_username => "root",
			admin_password => $mysql_admin_password,
			hostname       => $mysql_hostname,
			port           => $mysql_port;
	}
}
