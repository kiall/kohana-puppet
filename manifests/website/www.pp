class website::www inherits website
{
	# Setup a Kohana based site
	nginx::template::kohana {
		"www.kohanaframework.org":
			ensure   => present,
			fpm_port => 9001;
	}

	# Setup a http://kohanaframework.org -> http://www.kohanaframework.org redirect site
	nginx::template::redirect {
		"kohanaframework.org":
			ensure       => present,
			redirect_url => "http://www.kohanaframework.org";
	}

}
