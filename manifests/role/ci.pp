class role::ci inherits role
{
	include jenkins
	include website::ci
	include php
	include php::pear::phpunit
	include php::pear::phing
	include php::pear::phpcpd
	include php::pear::php_codesniffer_standards_kohana
	include php::pecl::xdebug

	package {
		"role-ci-git":
			ensure  => latest,
			name    => "git";
                "role-ci-php":
                        ensure  => latest,
                        name    => "php5-cli";
	}
}
