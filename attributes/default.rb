default['java']['jdk_version'] = 7

prefix = File.join "/", "opt", "elk-in-a-box"

default['elk-in-a-box']['prefix'] = prefix

default['elk-in-a-box']['user'] = 'logstash'
default['elk-in-a-box']['group'] = 'logstash'

default['elk-in-a-box']['logstash'] = {
	'version' => "1.4.2",
	'url' => 'https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz',
	'target-dir' => File.join(prefix, "logstash"),
	'config' => {
		'input' => {},
		'filter' => {},
		'output' => {}
	},
	'patterns' => {}
}

default['elk-in-a-box']['elasticsearch'] = {
	'version' => "1.4.2",
	'url' => 'https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.2.tar.gz',
	'target-dir' => File.join(prefix, "elasticsearch")
}

default['elk-in-a-box']['kibana'] = {
	'version' => "4.0.0-beta3",
	'url' => 'https://download.elasticsearch.org/kibana/kibana/kibana-4.0.0-beta3.tar.gz',
	'target-dir' => File.join(prefix, "kibana"),
	'search' => {},
	'visualization' => {},
	'dashboard' => {}
}

default['elk-in-a-box']['logstash']['config']['output']['file'] = {
	'template' => 'output_elasticsearch',
	'cookbook' => 'elk-in-a-box'
}