#
# Cookbook Name:: elk-in-a-box
# Recipe:: default
#
# Copyright (C) 2014 Christian Schwartz
#
# This cookbook is licensed under the MIT license.
# For the full license see github.com/cschwartz/elk-in-a-box/LICENSE
#

include_recipe 'apt'
include_recipe 'java'

prefix = node['elk-in-a-box']['prefix']

elk_user = node['elk-in-a-box']['user']
elk_group = node['elk-in-a-box']['group']

user elk_user do
  supports :manage_home => true
  shell "/bin/bash"
  home "/home/#{ elk_user }"
  action :create
end

group elk_group do
	members [elk_user]
end

directory prefix do
	action :create

	owner elk_user
	group elk_group
end

%w[logstash elasticsearch kibana].each do |component|
	component_tar = File.join "/", "tmp", "#{ component }.tar"
	version = node['elk-in-a-box'][component]['version']
	extracted_component = File.join prefix, "#{component}-#{version}" 
	
	remote_file component_tar do
		source node['elk-in-a-box'][component]['url']

		owner elk_user
		group elk_user
		
		not_if do File.exists? component_tar end
	end

	bash "extract['#{component}.tar']" do
		code <<-EOH 
tar -C #{ prefix } -xf #{ component_tar }
		EOH
		
		user elk_user
		group elk_group
		
		not_if do File.exists? extracted_component end
	end

	target_directory = node['elk-in-a-box'][component]['target-dir']

	link target_directory do
		to extracted_component

		owner elk_user
		group elk_group
	end

	template File.join "/", "etc", "init.d", component do
		mode "755"
		variables({home: target_directory,
			user: elk_user})
	end
end

%w[log config].each do |sub_dir|
	path = File.join node['elk-in-a-box']['logstash']['target-dir'], sub_dir
	directory path do
		owner elk_user
		group elk_group
		mode "755"
		action :create
	end
end

%w[logstash elasticsearch kibana].each do |component|
	service component do
	  action [ :enable, :start ]
	end
end

plugin_command = File.join node['elk-in-a-box']['elasticsearch']['target-dir'], 'bin', 'plugin'
execute "install elasticsearch-head" do
	command "bin/plugin --install mobz/elasticsearch-head"
	cwd node['elk-in-a-box']['elasticsearch']['target-dir']
	action :run
	not_if "#{ plugin_command } --list | grep 'head'"
end

config_path = path = File.join node['elk-in-a-box']['logstash']['target-dir'], 'config'

%w[input filter output].each do |type|
	node['elk-in-a-box']['logstash']['config'][type].each do |name, config|
		template File.join config_path, config['template'] do
			cookbook config['cookbook']
			owner elk_user
			group elk_group

			notifies :restart, "service[logstash]"
		end
	end
end

patterns_path = path = File.join node['elk-in-a-box']['logstash']['target-dir'], 'patterns'
node['elk-in-a-box']['logstash']['patterns'].each do |name, pattern|
	template File.join patterns_path, pattern['template'] do
		cookbook pattern['cookbook']
		owner elk_user
		group elk_group

		notifies :restart, "service[logstash]"
	end
end

node['elk-in-a-box']['kibana']['search'].each do |name, config| 
	search_description = {"title" => name,
			"description" => "",
			"hits" => 0,
			"columns" => ["_source"],
			"kibanaSavedObjectMeta" => {
				"searchSourceJSON" => config
				}
			}.to_json

	http_request "kibana search: '#{name}'" do
		url "http://localhost:9200/.kibana/search/#{name}"
		action :put
		
		message search_description
	end
end

node['elk-in-a-box']['kibana']['visualization'].each do |name, config| 
	visualization_description = {"title" => name,
			"description" => "",
			"visState" => config['visState'],
			"savedSearchId" => config['savedSearchId'],
			"kibanaSavedObjectMeta" => {
				"searchSourceJSON" => {"filter" => []}.to_json
				}
			}.to_json

	http_request "kibana visualization: '#{name}'" do
		action :put
		url "http://localhost:9200/.kibana/visualization/#{name}"
		message visualization_description
	end
end

node['elk-in-a-box']['kibana']['dashboard'].each do |name, panels| 
	dashboard_description = {"title" => name,
			"description" => "",
			"panelsJSON" => panels,
			"kibanaSavedObjectMeta" => {
				"searchSourceJSON" => {"filter" => ["query" => {"query_string" => "*"}]}.to_json
				}
			}.to_json

	http_request "kibana dashboard: '#{name}'" do
		action :put
		url "http://localhost:9200/.kibana/dashboard/#{name}"
		message dashboard_description
	end
end