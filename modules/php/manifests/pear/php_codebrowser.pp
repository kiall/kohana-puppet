class php::pear::php_codebrowser {
	package {
		"PHP_CodeBrowser":
			provider => "pear",
			source   => "phpunit",
			ensure   => "1.0.0";
	}
}
