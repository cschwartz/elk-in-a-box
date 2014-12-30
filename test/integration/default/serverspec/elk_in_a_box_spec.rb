require 'serverspec'

set :backend, :exec

describe user("logstash") do
	it { should exist }
	it { should have_login_shell '/bin/bash' }
	it { should have_home_directory '/home/logstash' }
	it { should belong_to_group 'logstash' }
end

describe group("logstash") do
  it { should exist }
end

describe file("/opt/elk-in-a-box/") do
	it { should be_directory }
end