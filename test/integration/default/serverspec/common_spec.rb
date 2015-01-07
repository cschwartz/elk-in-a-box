require 'serverspec'
require 'spec_helper'

set :backend, :exec

describe package("openjdk-7-jdk") do
  it { should be_installed }
end

describe user("logstash") do
	it { should exist }
	it { should have_login_shell '/bin/bash' }
	it { should have_home_directory '/home/logstash' }
	it { should belong_to_group 'logstash' }
end

describe file("/home/logstash") do
	it { should be_directory }
	it { should be_owned_by "logstash" }
	it { should be_grouped_into "logstash" }
end

describe group("logstash") do
  it { should exist }
end

describe file("/opt/elk-in-a-box/") do
	it { should be_directory }
	it { should be_owned_by "logstash" }
	it { should be_grouped_into "logstash" }
end