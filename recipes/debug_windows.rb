#
# Cookbook Name:: chef_debug
# Recipe:: debug_windows
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

if node["chef_debug"]["debug"]["enabled"] == true then

    directory "C:/Users/vagrant/.chef" do
      action :create
      recursive true
    end

    template "C:/Users/vagrant/.chef/knife.rb" do
      mode "0755"
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

    template "C:/opscode/chef/bin/debug.ps1" do
      mode "0644"
      source "/windows/debug.ps1.erb"
    end

    Windows
    template "C:/opscode/chef/bin/stop_debug.ps1" do
      mode "0644"
      source "/windows/stop_debug.ps1.erb"
    end

end

if node["chef_debug"]["debug"]["enabled"] == false then

    directory "C:/Users/vagrant/.chef" do
      action :create
      recursive true
    end

    template "C:/Users/vagrant/.chef/knife.rb" do
      mode "0755"
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

    # Windows
    # execute "linking" do
    #   command "Stop-Process chef-zero"
    #   action :run
    # end

end