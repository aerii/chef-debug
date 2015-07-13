default["chef_debug"]["debug"]["enabled"] = true

if node["chef_debug"]["debug"]["enabled"] == true then
  default["chef_debug"]["debug"]["service_name"] = 'chef-zero'
  default["chef_debug"]["debug"]["log_level"] = ':info'
  default["chef_debug"]["debug"]["log_location"] = 'STDOUT'
  default["chef_debug"]["debug"]["node_name"] = 'admin'
  default["chef_debug"]["debug"]["validation_client_name"] = 'chef-validator'
  default["chef_debug"]["debug"]["chef_server_url"] = 'http://127.0.0.1:8889'

  if node["platform_family"] == "windows" then
    default["chef_debug"]["debug"]["client_key"] = 'C:/Users/vagrant/AppData/Local/Temp/kitchen/client.pem'
    default["chef_debug"]["debug"]["validation_key"] = 'C:/Users/vagrant/AppData/Local/Temp/kitchen/validation.pem'
  elsif node["platform_family"] == "rhel" then
    default["chef_debug"]["debug"]["client_key"] = '/tmp/kitchen/client.pem'
    default["chef_debug"]["debug"]["validation_key"] = '/tmp/kitchen/validation.pem'
  end
end