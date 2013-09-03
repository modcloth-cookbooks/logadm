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

default['logadm']['write_conf_file'] = true
default['logadm']['conf_file'] = '/etc/logadm.conf'
default['logadm']['conf_file_template'] = 'logadm.conf.erb'
default['logadm']['conf_file_cookbook'] = 'logadm'

default['logadm']['enabled_patterns']['smf'] = true
default['logadm']['enabled_patterns']['apache'] = false
default['logadm']['enabled_patterns']['lighttpd'] = false
default['logadm']['enabled_patterns']['nginx'] = false
default['logadm']['enabled_patterns']['mysql'] = false

default['logadm']['patterns']['smf'] = '-C 3 -c -s 1m /var/svc/log/*.log'
default['logadm']['patterns']['apache'] = '-C 5 -c -s 100m /var/log/httpd/*.log'
default['logadm']['patterns']['lighttpd'] = "-C 5 -c -s 100m '/var/log/lighttpd/{access,error}.log'"
default['logadm']['patterns']['nginx'] = "-C 5 -c -s 100m '/var/log/nginx/{access,error}.log'"
default['logadm']['patterns']['mysql'] = "-C 5 -c -s 100m '/var/log/mysql/{error,slowquery}.log'"
