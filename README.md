Logadm Cookbook
=================
Provides a `logadm` resource to create/delete cron jobs for log rotation
and management.

Requirements
============

Chef version 0.10.10+.

Platform
--------

* SmartOS (presumably other SunOS)

Resources/Providers
===================

`logadm`
--------

Manage logadm.

### Actions

- :create: create a named log entry
- :delete: delete a named log entry

### Attribute Parameters

- :name: name attribute. Name of the log to set logadm rules to manage
- :manual_command: override all settings with one-liner command
- :path: path to log
- :count: number of logs to keep after rotating
- :size: size is number followed by bytes...kilobytes...etc
- :period: time period to rotate logs
- :copy: copy and truncate
- :template: template for naming of logs
- :gzip: count of rotated logs to keep uncompressed ( default: do not gzip ) ( specify 0 to compress all files )
- :use_local_time: use local time rather than UTC when name rotated files
- :post_command: execute command after renaming log files
- :pre_command: execute command before renaming log files

### Providers

- **Chef::Provider::Logadm**: shortcut resource `logadm`


Usage
=====

### Examples

``` ruby
# create a logadm entry
logadm "chef-client" do
  path "/var/log/chef/client.log"
  copy true
  size "1b"
  period "7d"
  action :create  
end

# nginx -C 5 -c -s 100m '/var/log/nginx/{access,error}.log'
logadm "nginx" do
  path "/var/log/nginx/{localhost.access,error}.log"
  copy true
  size "100m"
  count 5
  gzip 1
  action :create	
end
```
