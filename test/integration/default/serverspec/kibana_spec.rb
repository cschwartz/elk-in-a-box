require 'serverspec'
require 'spec_helper'

set :backend, :exec

describe "kibana" do
	describe file("/opt/elk-in-a-box/kibana-4.0.0-beta3") do
		it { should be_directory }
	end

	describe file("/opt/elk-in-a-box/kibana") do
		it { should be_linked_to "/opt/elk-in-a-box/kibana-4.0.0-beta3" }
		it { should be_owned_by "logstash" }
		it { should be_grouped_into "logstash" }
	end

	describe file("/etc/init.d/kibana") do
		it { should be_file }
	end

	describe service("kibana") do
	   	it { should be_running }
	end

	describe port(5601) do
		it { should be_listening }
	end
end

describe "logstash config" do
	describe file("/opt/elk-in-a-box/logstash/config/output_elasticsearch") do
		it { should be_file }
		its(:content) { should include "elasticsearch_http" }
		its(:content) { should include "localhost" }
		its(:content) { should include "9200" }
	end
end