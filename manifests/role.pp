import 'role/*.pp'

class role
{
	# Common packages
	package {
		[
			"puppet",
			"htop",
			"curl",
			"wget",
			"nano",
			"openssh-server",
			"mtr",
			"telnet",
			"ntp",
			"python-software-properties",
			"bash-completion",
			"rsync"
		]:
			ensure  => latest;
	}

	# Setup default umask ..
	file {
		"/etc/profile":
			source => "puppet:///files/etc/profile";
	}


	# Setup user accounts
	custom::user {
		"kiall":
			ensure => present,
			groups => [
				"developers",
				"admin",
				"www-www.kohanaframework.org",
				"www-dev.kohanaframework.org",
				"www-forum.kohanaframework.org"
			];
		"zombor":
			ensure => present,
			groups => [
				"developers",
				"admin",
				"www-www.kohanaframework.org",
				"www-dev.kohanaframework.org",
				"www-forum.kohanaframework.org"
			];
		"samsoir":
			ensure => present,
			groups => [
				"developers",
				"admin",
				"www-www.kohanaframework.org",
				"www-dev.kohanaframework.org",
				"www-forum.kohanaframework.org"
			];
		"isaiah":
			ensure => present,
			groups => [
				"developers",
				"admin",
				"www-www.kohanaframework.org",
				"www-dev.kohanaframework.org",
				"www-forum.kohanaframework.org"
			];
		"brmatt":
			ensure => present,
			groups => [
				"developers",
				"admin",
				"www-www.kohanaframework.org",
				"www-dev.kohanaframework.org",
				"www-forum.kohanaframework.org"
			];
	}

	# Setup SSH Keys
	ssh_authorized_key {
		"kiall@wk01-lmst.managedit.ie":
			ensure  => present,
			user    => "kiall",
			type    => "ssh-rsa",
			key     => "AAAAB3NzaC1yc2EAAAABIwAAAQEAl5eTgQ1IMCr9pFPiR1ZdpnNaORqmfCgqhSsUOv5E6w6anzc/K4Xj9wy5gxvrrG7hVqI7iNQ+Yddfcc4QXfMkUO9CPWUBC2bXs21Sy5nPnGyveJIro+LbBkf+FPyN/WL95O8ymJ/7V0Suo+XSTO25wu4LLe2t33QNtZpPYthD0amHGuVhbL97ie7dwA9iZQfGsGIgrd10+uGYNKlb+NwEF9i+w6t4tGjyjuE4cxo2E+/KmiwNShOXQ7eq4a0qf7kmz6ZIZEBo8Gut0OcmzL8bb4PxVbQsL1IqwkbNa4oN+w7+TLVbdmGxqYO0tgVz2FadgXEnX3jlzPWYyDTk2bbI/w==",
			options => [],
			require => User["kiall"];
                "kiall@kiall-laptop":
                        ensure  => present,
                        user    => "kiall",
                        type    => "ssh-rsa",
                        key     => "AAAAB3NzaC1yc2EAAAADAQABAAABAQCswAbmT3k9NojL9xQKWrW4yiveJLFqNBFmRvrXLjLb2CvwAMnMdNMQmuJe2olTopiWlEkryZl2o8hiDbGdYrMNU278tVKoU+XTkKxHd9+00cFT2rZCaL0umkWxkSUIGwEcl8dVDxQKuRK3FQ7+0t58wLmMqPU6qcZSA1ruOJ3XvBFZWQZk/keT4vCzZBY39QetX+ge5YhXSpYdwZ78T4x8QcEkuccuNxj7fOVXlaH6w9E8hP13VgjIWz3zrWM8ZmgiVE9ro1RokyFYPW4eb3jd6WRvDOjm7lEsD7mdKZB6ZXZ6IHtgAui0WtIcQqZCEYhz7yaaQ8mnHTd9N07yq8nf",
                        options => [],
                        require => User["kiall"];
		"matthew@sigswitch.com":
			ensure  => present,
			user    => "brmatt",
			type    => "ssh-rsa",
			key     => "AAAAB3NzaC1yc2EAAAABIwAAAQEAvR3hLb7gdXHGLWEu3Rt9hBpfidN7MXO/HOnX8BBoaz9RfrEr68SlKlKLpZ8MInUrOeCTq2E5NQpgcN7hPRh/aFM2oHpYPBx6z0EroaMROWJtujDEi5U1lWFKhywROMA5VTgkcizA11mjTABonccLiirzjPh0DgCU4bUMoKJpGfzNU/OJweyqDvEgyLib2NDL1ntrShzx5gkgc/24QliBhiu15ZBYXnrU1VrMF7SY13tB7TdEOC+/qpHU7Zz8TNLjzLoFKo/LSZWA6ZWagZj0YmLXj6R2CX1jvvaJiorQ1Z/neJ8EU1Qy+9qLKfYCa+QiJP9/RUaMhG0dFtRFkiT6YQ==",
			options => [],
			require => User["brmatt"];
	}

	# Export a nagios host
	@@nagios_host {
		$fqdn:
			ensure => present,
			alias => $hostname,
			address => $ipaddress,
			use => "generic-host";
	}

	# Export default nagios services
	@@nagios_service {
		"check_ping_${fqdn}":
			check_command       => "check_ping!100.0,20%!500.0,60%",
			use                 => "generic-service",
			host_name           => "$fqdn",
			notification_period => "24x7",
			service_description => "check_ping";
		"check_ssh_${fqdn}":
			check_command       => "check_ssh",
			use                 => "generic-service",
			host_name           => "$fqdn",
			notification_period => "24x7",
			service_description => "check_ssh";
	}

	# Run apt update each night (This is used so munin can tell how many out of date packages there are)
	cron {
		"apt-update":
			command => "/usr/bin/apt-get update",
			user    => root,
			hour    => 3,
			minute  => 25;
	}
}
