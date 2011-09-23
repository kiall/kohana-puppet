nagios_timeperiod {
	"24x7":
		ensure    => present,
		alias     => "24 Hours A Day, 7 Days A Week",
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

nagios_contactgroup {
	"admins":
		ensure  => present,
		alias   => "Nagios Administrators",
		members => "kiall",
		target  => "/etc/nagios3/conf.puppet.d/contactgroup.cfg",
		require => File["/etc/nagios3/conf.puppet.d/contactgroup.cfg"],
		notify  => Service["nagios3"];
}

nagios_contact {
	"kiall":
		ensure                        => present,
		email                         => "kiall.macinnes@kohanaframework.org",
        service_notification_period   => "24x7",
        host_notification_period      => "24x7",
        service_notification_options  => "w,u,c,r",
        host_notification_options     => "d,r",
        service_notification_commands => "notify-service-by-email",
        host_notification_commands    => "notify-host-by-email",
		target                        => "/etc/nagios3/conf.puppet.d/contact.cfg",
		require                       => File["/etc/nagios3/conf.puppet.d/contact.cfg"],
		notify                        => Service["nagios3"];
}