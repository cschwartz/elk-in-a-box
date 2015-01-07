default['elk-in-a-box']['logstash']['config']['input']['file'] = {
	'template' => 'input_file',
	'cookbook' => 'elk-in-a-box-simple-example'
}

default['elk-in-a-box']['logstash']['config']['filter']['grok_syslog'] = {
	'template' => 'filter_grok_syslog',
	'cookbook' => 'elk-in-a-box-simple-example'
}

default['elk-in-a-box']['logstash']['patterns']['example'] = {
	'template' => 'example',
	'cookbook' => 'elk-in-a-box-simple-example'
}

default['elk-in-a-box']['kibana']['search']['syslog'] = <<JSON
{
  "highlight": {
    "pre_tags": [
      "@kibana-highlighted-field@"
    ],
    "post_tags": [
      "@/kibana-highlighted-field@"
    ],
    "fields": {
      "*": {}
    }
  },
  "filter": [
    null,
    {
      "meta": {
        "disabled": false,
        "index": "logstash-*",
        "key": "type",
        "negate": false,
        "value": "syslog"
      },
      "query": {
        "match": {
          "type": {
            "query": "syslog",
            "type": "phrase"
          }
        }
      },
      "$$hashKey": "0WR"
    }
  ],
  "index": "logstash-*"
}
JSON

default['elk-in-a-box']['kibana']['visualization']['syslogPrograms']['savedSearchId'] = 'syslog'
default['elk-in-a-box']['kibana']['visualization']['syslogPrograms']['visState'] = <<JSON
{
  "aggs": [
    {
      "id": 1,
      "params": {},
      "schema": "metric",
      "type": "count"
    },
    {
      "id": 2,
      "params": {
        "exclude": {
          "flags": []
        },
        "field": "program",
        "include": {
          "flags": []
        },
        "order": "desc",
        "size": 5
      },
      "schema": "segment",
      "type": "terms"
    }
  ],
  "listeners": {},
  "params": {
    "addLegend": true,
    "addTooltip": true,
    "isDonut": false,
    "shareYAxis": true
  },
  "type": "pie"
}
JSON

default['elk-in-a-box']['kibana']['dashboard']['syslogDashboard'] = <<JSON
[
  {
    "visId": "syslogPrograms",
    "size_x": 12,
    "size_y": 6,
    "col": 1,
    "row": 1
  }
]
JSON