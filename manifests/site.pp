# necessary defaults
Exec { path => "/var/lib/gems/1.8/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin" }

# Define the bucket and specify it as the default target
filebucket { main: server => "puppet.kohanaframework.org" }
File { backup => main }

# Setup extlookup
$extlookup_datadir = "/etc/puppet-extlookup"
$extlookup_precedence = ["fqdn_%{fqdn}", "domain_%{domain}", "common"]

# Import Modules
import 'common'
import 'nginx'
import 'php'
import 'ruby'
import 'database'
import 'mysql'
import 'nagios'

# Import files..
import "custom.pp"
import "common.pp"
import "users.pp"
import "role.pp"
import 'website.pp'
import "nagios.pp"
import "nodes.pp"