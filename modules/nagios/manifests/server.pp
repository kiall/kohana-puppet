class nagios::server {
	include nagios::server::purge

	package {
		[
			nagios3,
			nagios-plugins,
			nagios-plugins-extra,
			fcgiwrap
		]:
			ensure => installed;
	}

	service {
		"nagios3":
			ensure    => running,
			enable    => true,
			require   => Package[nagios3];
	}

	user {
		"nagios":
			ensure    => present,
			groups    => ["www-data"],
			require   => Package[nagios3];
	}

	# Collect resources and populate /etc
	Nagios_host <<||>> {
		target  => "/etc/nagios3/conf.puppet.d/host.cfg",
		require => File["/etc/nagios3/conf.puppet.d/host.cfg"],
		notify  => Service["nagios3"]
	}

	Nagios_service <<||>> {
		target  => "/etc/nagios3/conf.puppet.d/service.cfg",
		require => File["/etc/nagios3/conf.puppet.d/service.cfg"],
		notify  => Service["nagios3"]
	}

	# Setup a nagios site
	nginx::template::nagios {
		"nagios.kohanaframework.org":
			ensure    => present;
	}

	nagios_timeperiod {
		"default-prevents-errors":
			ensure    => present,
			alias     => "Default timeperiod to allow nagios to boot",
			sunday    => "00:00-24:00",
			monday    => "00:00-24:00",
			tuesday   => "00:00-24:00",
			wednesday => "00:00-24:00",
			thursday  => "00:00-24:00",
			friday    => "00:00-24:00",
			saturday  => "00:00-24:00",
			target    => "/etc/nagios3/conf.puppet.d/timeperiod.cfg",
			require   => File["/etc/nagios3/conf.puppet.d/timeperiod.cfg"],
			notify    => Service["nagios3"];
	}

	# Copy some static config files over..
	file {
		"/var/lib/nagios3":
			ensure   => directory,
			mode     => 755,
			owner    => nagios,
			group    => nagios,
			require  => Package[nagios3];
		"/var/lib/nagios3/rw":
			ensure   => directory,
			mode     => 775,
			owner    => nagios,
			group    => www-data,
			require  => Package[nagios3];
		"/var/lib/nagios3/rw/nagios.cmd":
			ensure   => present,
			mode     => 770,
			owner    => nagios,
			group    => www-data,
			require  => Package[nagios3];
		"/etc/nagios3/cgi.cfg":
			ensure   => present,
			source   => "puppet:///nagios/etc/nagios3/cgi.cfg",
			mode     => 644,
			owner    => root,
			group    => root,
			require  => Package[nagios3];
		"/etc/nagios3/commands.cfg":
			ensure   => present,
			source   => "puppet:///nagios/etc/nagios3/commands.cfg",
			mode     => 644,
			owner    => root,
			group    => root,
			require  => Package[nagios3];
		"/etc/nagios3/nagios.cfg":
			ensure   => present,
			source   => "puppet:///nagios/etc/nagios3/nagios.cfg",
			mode     => 644,
			owner    => root,
			group    => root,
			require  => Package[nagios3];
		"/etc/nagios3/resource.cfg":
			ensure   => present,
			source   => "puppet:///nagios/etc/nagios3/resource.cfg",
			mode     => 644,
			owner    => root,
			group    => root,
			require  => Package[nagios3];
		"/etc/nagios3/templates.cfg":
			ensure   => present,
			source   => "puppet:///nagios/etc/nagios3/templates.cfg",
			mode     => 644,
			owner    => root,
			group    => root,
			require  => Package[nagios3];
		"/etc/nagios3/conf.puppet.d":
			ensure   => directory,
			mode     => 644,
			owner    => root,
			group    => root,
			require  => Package[nagios3];
		"/etc/nagios3/conf.puppet.d/host.cfg":
			ensure   => present,
			mode     => 644,
			owner    => root,
			group    => root,
			require  => Package[nagios3];
		"/etc/nagios3/conf.puppet.d/service.cfg":
			ensure   => present,
			mode     => 644,
			owner    => root,
			group    => root,
			require  => Package[nagios3];
		"/etc/nagios3/conf.puppet.d/timeperiod.cfg":
			ensure   => present,
			mode     => 644,
			owner    => root,
			group    => root,
			require  => Package[nagios3];
		"/etc/nagios3/conf.puppet.d/contactgroup.cfg":
			ensure   => present,
			mode     => 644,
			owner    => root,
			group    => root,
			require  => Package[nagios3];
		"/etc/nagios3/conf.puppet.d/contact.cfg":
			ensure   => present,
			mode     => 644,
			owner    => root,
			group    => root,
			require  => Package[nagios3];
	}
}