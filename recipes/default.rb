#
# Cookbook Name:: elk-in-a-box
# Recipe:: default
#
# Copyright (C) 2014 Christian Schwartz
#
# This cookbook is licensed under the MIT license.
# For the full license see github.com/cschwartz/elk-in-a-box/LICENSE
#

prefix = node['elk-in-a-box']['prefix']

logstash_user = node['elk-in-a-box']['user']
logstash_group = node['elk-in-a-box']['group']

directory prefix do
	action :create
end

user logstash_user do
  shell "/bin/bash"
  home "/home/#{ logstash_user }"
  action :create
end

group logstash_group do
	members [logstash_user]
end
