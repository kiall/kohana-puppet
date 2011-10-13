class php::pear::behat {
	package {
		"behat":
			provider => "pear",
			source   => "behat",
			ensure   => latest;
	}
}
