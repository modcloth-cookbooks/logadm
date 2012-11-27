
# logadm -w apache -p 1m -C 24\
#             -t '/var/apache/old-logs/$basename.%Y-%m'\
#             -a '/usr/apache/bin/apachectl graceful'\
#             '/var/apache/logs/*{access,error}_log'

# logadm -w /var/squid/logs/cache.log -C 8 -c -p 1d -t '/var/squid/logs/cache.log.$n' -z 1 

action :create do

	if new_resource.manual_command
		cmd = new_resource.manual_command
	else
	  cmd = "logadm -w #{new_resource.name} '#{new_resource.path}'"
	  args = []
  	args << "-c" if new_resource.copy
  	args << " -C #{new_resource.count}" if new_resource.count
  	args << " -s #{new_resource.size}" if new_resource.size
    args << " -p #{new_resource.period}"	if new_resource.period
    args << " -t #{new_resource.template}"  if new_resource.template
    args << " -z #{new_resource.gzip}"  if new_resource.gzip
    cmd  << ' ' + args.join(' ')
	end

  Chef::Log.info("logadm command: #{cmd}")

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