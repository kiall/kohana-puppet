class website::pear inherits website
{
	# Setup a static site
	nginx::template::static {
		"pear.kohanaframework.org":
			ensure   => present;
	}

}
