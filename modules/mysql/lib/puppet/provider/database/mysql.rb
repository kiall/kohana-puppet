Puppet::Type.type(:database).provide(:mysql) do
	desc "Manages a mysql database."

	def create
		db = get_connection()

		db.query("CREATE DATABASE IF NOT EXISTS `#{@resource[:name]}`")

		return true
	rescue
		return false
	ensure
		db.close
	end

	def destroy
		db = get_connection()

		db.query("DROP DATABASE IF EXISTS `#{@resource[:name]}`")

		return true
	rescue
		return false
	ensure
		db.close
	end

	def exists?
		db = get_connection()

		results = db.query("SHOW DATABASES")

		results.each do |row|
			return true if (row.to_s == @resource[:name])
		end

		return false
	ensure
		db.close
	end

	private
	def get_connection()
		require 'mysql'
		Mysql.new(@resource[:hostname], @resource[:admin_username], @resource[:admin_password], "mysql", @resource[:port].to_i)
	end
end