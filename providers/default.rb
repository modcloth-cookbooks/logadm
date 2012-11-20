
# logadm -w apache -p 1m -C 24\
#             -t '/var/apache/old-logs/$basename.%Y-%m'\
#             -a '/usr/apache/bin/apachectl graceful'\
#             '/var/apache/logs/*{access,error}_log'

# logadm -w /var/squid/logs/cache.log -C 8 -c -p 1d -t '/var/squid/logs/cache.log.$n' -z 1 

action :create do

	if new_resource.manual_command
		cmd = new_resource.manual_command
	else
	  cmd = "logadm -w #{new_resource.name} #{new_resource.path}"

		if new_resource.copy
	  	cmd << " -c"
	  end
	  if new_resource.count
	  	cmd << " -C#{new_resource.count}"
	  end
	  if new_resource.template
	  	cmd << " -t #{new_resource.template}"
	  end
	end

  execute "logadm add entry #{new_resource.name}" do
    command cmd
  end
end
 
action :delete do
  if new_resource.manual_command
		cmd = new_resource.manual_command
	else
		cmd = "logadm -r #{new_resource.name}"
	end

  execute "logadm delete entry #{new_resource.name}" do
    only_if "logadm -V #{new_resource.name}"
    command cmd
  end

end