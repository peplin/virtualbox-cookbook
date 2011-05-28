#
# Cookbook Name:: virtualbox
# Recipe:: default
#
# Copyright 2011, Joshua Timberman
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'open-uri'

case node['platform']
when "mac_os_x"
  distfile = "-OSX.dmg"
when "ubuntu","debian"
  distfile = "~#{node['platform'].capitalize}~#{node['lsb']['codename']}_#{node['virtualbox']['arch']}.deb"
end

filename = "#{node['virtualbox']['version']}#{distfile}"
url = node['virtualbox']['url'].empty? ? "#{node['virtualbox']['urlbase']}/#{filename}" : node['virtualbox']['url']
target = "#{Chef::Config[:file_cache_path]}/#{filename}"

sha256sum = "" # retrieve the sha256sums from the virtualbox mirror
open("#{node['virtualbox']['urlbase']}/SHA256SUMS").each do |line|
  sha256sum = line.split(" ")[0] if line =~ /#{distfile}/
end

case node['platform']
when "mac_os_x"

  dmg_package "Virtualbox" do
    source url
    type "mpkg"
    checksum sha256sum
  end

when "ubuntu","debian"

  remote_file target do
    source url
    mode 0644
    checksum sha256sum
  end

  dpkg_package "virtualbox" do
    source target
  end

end

