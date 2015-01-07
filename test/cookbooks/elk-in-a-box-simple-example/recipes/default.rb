include_recipe "elk-in-a-box"

group "adm" do
	members node['elk-in-a-box']['user']
	append true
end