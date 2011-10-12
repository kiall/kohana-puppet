define nginx::template::static($ensure = 'present', $listen = 80, $order = '100') {
	include nginx

	# Setup the nGinx virtual host
	nginx::site {
		$name:
			ensure	=> $ensure,
			content => template("nginx/template/static.conf.erb"),
			order   => $order;
	}
}
