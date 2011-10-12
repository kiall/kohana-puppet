class nagios::server::purge {
	# From .. http://www.mnxsolutions.com/linux/automatically-purge-old-configuration-from-nagios-deployed-by-puppet.html
	# But it doesnt seem to work -_-

	resources { "nagios_service":
        purge => true
    }
    resources { "nagios_host":
        purge => true
    }
    resources { "nagios_hostgroup":
        purge => true
    }
}