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
# logadm -w /var/squid/logs/cache.log -C 8 -c -p 1d -t '/var/squid/logs/cache.log.$n' -z 1
#
# Example 6 Rotating the apache Error and Access Logs
#
#      The following example rotates the apache error and access logs
#      monthly to filenames based on current year and month. It keeps
#      the 24 most recent copies and tells apache to restart after
#      renaming the logs.
#
#      This command is run once, and since the -w option is specified,
#      an entry is made in /etc/logadm.conf so the apache logs are
#      rotated from now on.
#
#         % logadm -w apache -p 1m -C 24\
#             -t '/var/apache/old-logs/$basename.%Y-%m'\
#             -a '/usr/apache/bin/apachectl graceful'\
#             '/var/apache/logs/*{access,error}_log'
#
#      This example also illustrates that the entry name supplied with
#      the -w option doesn't have to match the log file name. In this
#      example, the entry name is apache and once the line has been run,
#      the entry in /etc/logadm.conf can be forced to run by executing
#      the following command:
#
#        % logadm -p now apache
#
#      Because the expression matching the apache log file names was
#      enclosed in quotes, the expression is stored in /etc/logadm.conf,
#      rather than the list of files that it expands to. This means that
#      each time logadm runs from cron it expands that expression and
#      checks all the log files in the resulting list to see if they
#      need rotating.
#
#      The following command is an example without the quotes around the
#      log name expression. The shell expands the last argument into a
#      list of log files that exist at the time the command is entered,
#      and writes an entry to /etc/logadm.conf that rotates the files.
#
#        logadm -w apache /var/apache/logs/*_log
#



actions :create, :delete

default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :manual_command, :kind_of => [String, NilClass], :default => nil
attribute :path, :kind_of => String
attribute :count, :kind_of => Integer
# size is number followed by bytes...kilobytes...etc
attribute :size, :regex => /^[0-9]+[bkmg]$/
# later should add now and never for period
attribute :period, :regex => /^[0-9]+[hdwmy]$/
attribute :copy, :default => true
attribute :template, :kind_of => String
attribute :gzip, :kind_of => Integer
