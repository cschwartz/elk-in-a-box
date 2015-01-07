require 'serverspec'
require 'spec_helper'

set :backend, :exec

describe "logstash" do
	describe file("/opt/elk-in-a-box/logstash-1.4.2") do
		it { should be_directory }
	end

	describe file("/opt/elk-in-a-box/logstash") do
		it { should be_linked_to "/opt/elk-in-a-box/logstash-1.4.2" }
		it { should be_owned_by "logstash" }
		it { should be_grouped_into "logstash" }
	end

	describe file("/etc/init.d/logstash") do
		it { should be_file }
	end

	describe file("/opt/elk-in-a-box/logstash/log") do
		it { should be_directory }
		it { should be_owned_by "logstash" }
		it { should be_grouped_into "logstash" }
		it { should be_mode "755" }
	end

	describe file("/opt/elk-in-a-box/logstash/config") do
		it { should be_directory }
		it { should be_owned_by "logstash" }
		it { should be_grouped_into "logstash" }
		it { should be_mode "755" }
	end

	describe file("/opt/elk-in-a-box/logstash/patterns") do
		it { should be_directory }
		it { should be_owned_by "logstash" }
		it { should be_grouped_into "logstash" }
		it { should be_mode "755" }
	end
	
	describe service("logstash") do
		it { should be_enabled }
	end
end
