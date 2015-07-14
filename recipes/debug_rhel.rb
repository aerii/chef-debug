#
# Cookbook Name:: chef_debug
# Recipe:: debug_rhel
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

if node["chef_debug"]["debug"]["enabled"] == true then

    directory "/root/.chef" do
      action :create
      recursive true
    end

    template "/root/.chef/knife.rb" do
      mode "0755"
      owner "root"
      user "root"
      group "root"
      source "knife.rb.erb"
      variables({
        :log_level => node["chef_debug"]["debug"]["log_level"],
        :log_location => node["chef_debug"]["debug"]["log_location"],
        :node_name => node["chef_debug"]["debug"]["node_name"],
        :client_key => node["chef_debug"]["debug"]["client_key"],
        :validation_client_name => node["chef_debug"]["debug"]["validation_client_name"],
        :validation_key => node["chef_debug"]["debug"]["validation_key"],
        :chef_server_url => node["chef_debug"]["debug"]["chef_server_url"]
      })
    end

    template "/usr/local/bin/debug.sh" do
      mode "0755"
      owner "root"
      user "root"
      group "root"
      source "/rhel/debug.sh.erb"
    end

    template "/usr/local/bin/stop_debug.sh" do
      mode "0755"
      owner "root"
      user "root"
      group "root"
      source "/rhel/stop_debug.sh.erb"
    end

end