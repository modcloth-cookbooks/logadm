#
# Copyright (c) 2013 ModCloth, Inc.
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
# of the Software, and to permit persons to whom the Software is furnished to do
# so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

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
    args << " -t '#{new_resource.template}'"  if new_resource.template
    args << " -z #{new_resource.gzip}"  if new_resource.gzip
    cmd  << ' ' + args.join(' ')
  end

  Chef::Log.info("logadm command: #{cmd}")

  execute "logadm add entry #{new_resource.name}" do
    command cmd
  end

  new_resource.updated_by_last_action(true)
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

  new_resource.updated_by_last_action(true)
end
