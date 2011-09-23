Puppet::Type.newtype(:database) do
	@doc = "Manage databases"

	ensurable

	newparam(:hostname) do
        desc "The database server hostname"
    end

	newparam(:port) do
        desc "The database server port"
    end

	newparam(:admin_username) do
        desc "The database server admin username"
    end

	newparam(:admin_password) do
        desc "The database server admin password"
    end

	newparam(:name) do
        desc "The database name"
    end
end