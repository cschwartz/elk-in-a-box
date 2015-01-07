# elk-in-a-box-cookbook

elk-in-a-box (not official in any kind or supported by elasticsearch) is a library cookbook to get up and running with an ELK-stack for local data analysis. 

For an example to get started, take a look at `test/cookbooks/elk-in-a-box-simple-example`, which converges a node monitoring its own `/var/log/syslog`.

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
  <tr>
    <td><tt>['elk-in-a-box']['logstash']['config']['input']</tt></td>
    <td>Hash</td>
    <td>input configuration files for logstash. Hash key is the identifier of the configuration file, value is a hash describing the config file. Available options are: `template` (name of the template to use) and `cookbook` (cookbook containing the template).</td>
    <td><tt>{}</tt></td>
  </tr>
  <tr>
    <td><tt>['elk-in-a-box']['logstash']['config']['filter']</tt></td>
    <td>Hash</td>
    <td>filter configuration files for logstash. Hash key is the identifier of the configuration file, value is a hash describing the config file. Available options are: `template` (name of the template to use) and `cookbook` (cookbook containing the template).</td>
    <td><tt>{}</tt></td>
  </tr>
  <tr>
    <td><tt>['elk-in-a-box']['logstash']['config']['output']</tt></td>
    <td>Hash</td>
    <td>input configuration files for logstash. Hash key is the identifier of the configuration file, value is a hash describing the config file. Available options are: `template` (name of the template to use) and `cookbook` (cookbook containing the template).</td>
    <td><tt>{'elasticsearch' => {'template' => 'output_elasticsearch', 'cookbook' => 'elk-in-a-box'}}</tt></td>
  </tr>
  <tr>
    <td><tt>['elk-in-a-box']['logstash']['patterns']</tt></td>
    <td>Hash</td>
    <td>grok patterns for logstash. Hash key is the identifier of the configuration file, value is a hash describing the pattern file. Available options are: `template` (name of the template to use) and `cookbook` (cookbook containing the template).</td>
    <td><tt>{}</tt></td>
  </tr>
  <tr>
    <td><tt>['elk-in-a-box']['kibana']['search']</tt></td>
    <td>Hash</td>
    <td>JSON description of searches you want preconfigured in your ELK. You can copy this from the objects pane in kibana. Keys of the hash are the titles of the search, value is the JSON description.</td>
    <td><tt>{}</tt></td>
  </tr>
  <tr>
    <td><tt>['elk-in-a-box']['kibana']['visualization']</tt></td>
    <td>Hash</td>
    <td>Description of visualization to preconfigure. Key of the hash is the name of the visualization, value is another hash. Here, two things need to be configured: `savedSearchId`, the id of the search to use for this visualization and `visState`, the JSON describing the visualization itself. This description can be copied from kibana's objects pane.</td>
    <td><tt>{}</tt></td>
  </tr>
  <tr>
    <td><tt>['elk-in-a-box']['kibana']['dashboard']</tt></td>
    <td>Hash</td>
    <td>Description of dashboards to preconfigure. Key of the hash is the name of the dashboard, value is the JSON description of the dashboard which, again, can be found the object pane.</td>
    <td><tt>{}</tt></td>
  </tr>
</table>

## Usage

### elk-in-a-box::default

Create a host cookbook, featuring depending on `elk-in-a-box` and include the recipe `elk-in-a-box::default`.
Make the files you want to analyse available to the host, e.g. via a shared folder or a NFS mount. Create the templates for the logstash configuration. For examples see the test cookbool `simple-example`.
Converge your node, if your using a local VM you might want to forward port 5601, where kibana is running.
Create searches, visualizations and dashboards. If you want to persist those, you can use the attributes described in the Attributes section of this document.
Note, that kibana 4 is beta and the representations of searches could change (also, I'm pretty sure storing this descriptions is not supported, this is pretty much a hack to support forwarding virtualization to other ELK instances running locally). 

## License and Authors

Author:: Christian Schwartz (christian.schwartz@gmail.com)
