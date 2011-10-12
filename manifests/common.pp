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
		"rsync",
		"git"
	]:
		ensure  => latest;
}

# Setup default umask ..
file {
	"/etc/profile":
		source => "puppet:///files/etc/profile";
	"/etc/sudoers.d/100-puppet":
		source => "puppet:///files/etc/sudoers.d/100-puppet",
		mode   => 0440;
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
