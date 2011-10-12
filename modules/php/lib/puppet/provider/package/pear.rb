require 'puppet/provider/package'

# PHP PEAR support.
Puppet::Type.type(:package).provide :pear, :parent => Puppet::Provider::Package do
  desc "PHP PEAR support."
  
  has_feature :versionable
  has_feature :upgradeable
  
  case Facter.value(:operatingsystem)
  when "Solaris"
    commands :pearcmd => "/opt/coolstack/php5/bin/pear"
  else
    commands :pearcmd => "pear"
  end

  def self.pearlist(hash)
    command = [command(:pearcmd), "list", "-a"]

    begin
      list = execute(command).collect do |set|
        if hash[:justme]
          if  set =~ /^hash[:justme]/
            if pearhash = pearsplit(set)
              pearhash[:provider] = :pear
              pearhash
            else
              nil
            end
          else
            nil
          end
        else
          if pearhash = pearsplit(set)
            pearhash[:provider] = :pear
            pearhash
          else
            nil
          end
        end

      end.reject { |p| p.nil? }
    rescue Puppet::ExecutionFailure => detail
      raise Puppet::Error, "Could not list pears: %s" % detail
    end

    if hash[:justme]
      return list.shift
    else
      return list
    end
  end

  def self.pearsplit(desc)
    case desc
    when /^INSTALLED/: return nil
    when /^=/: return nil
    when /^PACKAGE/: return nil
    when /^\(/: return nil
    when /^\n/: return nil
    when /^(\S+)\s+([.\d]+)\s+\S+\n/
      name = $1
      version = $2
      return {
        :name => name,
        :ensure => version
      }
    else
      Puppet.warning "Could not match '%s'" % desc
      nil
    end
  end

  def self.instances
    pearlist(:local => true).collect do |hash|
      new(hash)
    end
  end

  def install(useversion = true)
    command = ["upgrade", "--onlyreqdeps", "-f"]

    if (! @resource.should(:ensure).is_a? Symbol) and useversion
      if (@resource[:source])
        command << "#{@resource[:source]}/#{@resource[:name]}-#{@resource.should(:ensure)}"
      else
        command << "#{@resource[:name]}-#{@resource.should(:ensure)}"
      end
    else
      if (@resource[:source])
        command << "#{@resource[:source]}/#{@resource[:name]}"
      else
        command << "#{@resource[:name]}"
      end
    end

    pearcmd(*command)
  end

  def latest
    # This always gets the latest version available.
    version = ''
    if (@resource[:source])
      command = [command(:pearcmd), "remote-info", "#{@resource[:source]}/#{@resource[:name]}"]
    else
      command = [command(:pearcmd), "remote-info", @resource[:name]]
    end
    list = execute(command).collect do |set|
      if set =~ /^Latest/
        version = set.split[1]
      end
    end
    return version
  end

  def query
    self.class.pearlist(:justme => @resource[:name])
  end

  def uninstall
    output = pearcmd "uninstall", @resource[:name]
    if output =~ /^uninstall ok/
    else
      raise Puppet::Error, output
    end
  end

  def update
    self.install(false)
  end
end

