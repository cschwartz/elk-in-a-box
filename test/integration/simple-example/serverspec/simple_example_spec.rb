require 'serverspec'
require 'spec_helper'

set :backend, :exec

describe user('logstash') do
	it { should belong_to_group 'adm' }
end

describe "logstash configs" do
	describe file('/opt/elk-in-a-box/logstash/config/input_file') do
		it { should be_file }
		its(:content) { should include "/var/log/syslog" }
	end

	describe file('/opt/elk-in-a-box/logstash/config/filter_grok_syslog') do
		it { should be_file }
		its(:content) { should include "grok" }
	end
end

describe "grok patterns" do
	describe file("/opt/elk-in-a-box/logstash/patterns/example") do
		it { should be_file }
	end
end

describe "kibana" do
	describe "search" do
		describe http("localhost:9200/.kibana/search/syslog") do
			its(:status) { should eq 200 }
		end
	end

	describe "visualizations" do
		describe http("localhost:9200/.kibana/visualization/syslogPrograms") do
			its(:status) { should eq 200 }
		end
	end

	describe "dashboards" do
		describe http("localhost:9200/.kibana/dashboard/syslogDashboard") do
			its(:status) { should eq 200 }
		end
	end
end