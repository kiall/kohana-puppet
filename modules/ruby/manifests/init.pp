class ruby {

	package {
		[
			"ruby",
			"ruby1.8",
			"ruby1.9.1",
			"rubygems",
			"rubygems1.8",
		]:
			ensure => installed
	}

}