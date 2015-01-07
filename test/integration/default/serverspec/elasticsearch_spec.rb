require 'serverspec'
require 'spec_helper'

set :backend, :exec

describe "elasticsearch" do
	describe file("/opt/elk-in-a-box/elasticsearch-1.4.2") do
		it { should be_directory }
	end

	describe file("/opt/elk-in-a-box/elasticsearch") do
		it { should be_linked_to "/opt/elk-in-a-box/elasticsearch-1.4.2" }
		it { should be_owned_by "logstash" }
		it { should be_grouped_into "logstash" }
	end

	describe file("/etc/init.d/elasticsearch") do
		it { should be_file }
	end

	describe service("elasticsearch") do
	   	it { should be_running }
	end

	describe port(9200) do
		it { should be_listening }
	end

	describe http("localhost:9200") do
		its(:status) { should eq 200 }
		its(:body) { should include "You Know, for Search" }
	end

	describe http("localhost:9200/_plugin/head/") do
		its(:status) { should eq 200 }
	end
end