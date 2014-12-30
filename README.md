# elk-in-a-box-cookbook

TODO: Enter the cookbook description here.

## Supported Platforms

* ubuntu-12.04

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['elk-in-a-box']['prefix']</tt></td>
    <td>String</td>
    <td>Prefix for the ELK-stack installation</td>
    <td><tt>/opt/elk-in-a-box</tt></td>
  </tr>
  <tr>
    <td><tt>['elk-in-a-box']['user']</tt></td>
    <td>String</td>
    <td>User for running the ELK services</td>
    <td><tt>logstash</tt></td>
  </tr>
  <tr>
    <td><tt>['elk-in-a-box']['group']</tt></td>
    <td>String</td>
    <td>Group for running the ELK services</td>
    <td><tt>logstash</tt></td>
  </tr>
</table>

## Usage

### elk-in-a-box::default

Include `elk-in-a-box` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[elk-in-a-box::default]"
  ]
}
```

## License and Authors

Author:: Christian Schwartz (christian.schwartz@gmail.com)
