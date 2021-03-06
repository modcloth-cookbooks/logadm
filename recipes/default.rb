#
# Cookbook Name:: logadm
# Recipe:: default
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

template node['logadm']['conf_file'] do
  source node['logadm']['conf_file_template']
  cookbook node['logadm']['conf_file_cookbook']
  mode 0644
  only_if { node['logadm']['write_conf_file'] }
end

unless (rotated_logs = (node['logadm']['rotated_logs'] || {})).empty?
  node['logadm']['rotated_logs'].each do |service, log_config|
    logadm service do
      path log_config['path']
      copy log_config['copy']
      count log_config['count']
      size log_config['size']
      period log_config['period']
      template log_config['template']
      gzip log_config['gzip']
      action :create
    end
  end
end
