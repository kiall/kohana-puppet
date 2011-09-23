class mysql::server inherits mysql::client {
	$root_password = extlookup("mysql_root_password", false)

	if !$root_password {
		err("A mysql root password is required!")
	}

	dpkg::preseed_package {
		"mysql-server":
			ensure           => installed,
			preseed_content  => template("mysql/preseed.erb");
	}

	service {
		"mysql":
			ensure => running;
	}

	# TODO:
	# GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'XXX' WITH GRANT OPTION;
	# FLUSH PRIVILEGES;

	# Export default nagios services
	@@nagios_service {
		"check_mysql":
			check_command       => "check_mysql_cmdlinecred!root!${root_password}",
			use                 => "generic-service",
			host_name           => "$fqdn",
			notification_period => "24x7",
			service_description => "check_mysql";
	}
}