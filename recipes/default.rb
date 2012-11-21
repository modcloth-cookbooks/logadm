#
# Cookbook Name:: logadm
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# logadm "chef-client" do
# 	manual_command "logadm -r /var/log/chef/chef.client"
# 	# path "/var/log/chef/client.log"
# 	# copy false
# 	action 	
# end

logadm "chef-client" do
	path "/var/log/chef/client.log"
	copy true
	size "1b"
	period "7d"
	action :create	
end

# logadm "chef-client" do
# 	action :delete	
# end