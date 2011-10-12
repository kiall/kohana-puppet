define nginx::template::nagios($ensure = 'present', $listen = 80, $order = '100') {
	include nginx

	# Setup the nGinx virtual host
	nginx::site {
		$name:
			ensure	=> $ensure,
			content => template("nginx/template/nagios.conf.erb"),
			order   => $order;
	}
}
