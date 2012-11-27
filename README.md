Logadm Cookbook
=================
Provides a SmartOS Logadm resource to create/delete cron jobs for 
log rotation and management

Requirements
============

Chef version 0.10.10+.

Platform
--------

* SmartOS

Resources/Providers
===================

`logadm`
----------

Manage logadm.

### Actions

- :create: create a named log entry
- :delete: delete a named log entry

### Attribute Parameters

- :name: name attribute. Name of the log to set logadm rules to manage
- :manual_command: override all settings with one-liner command
- :path: path to log
- :count: number of 
- :size: size is number followed by bytes...kilobytes...etc
- :period:
- :copy:
- :template:

### Providers

- **Chef::Provider::Logadm**: shortcut resource `logadm`


Usage
=====

### Examples

    # create a logadm entry
    logadm "chef-client" do
      path "/var/log/chef/client.log"
      copy true
      size "1b"
      period "7d"
      action :create  
    end


License and Author
==================

- Author:: Stephen Lauck (<s.lauck@modcloth.com>)

Copyright 2009-2012, Modcloth, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
