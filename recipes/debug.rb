#
# Cookbook Name:: chef_debug
# Recipe:: debug
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "chef_debug::debug_#{node['platform_family']}"

# ! Code below for debug testing !

breakpoint "before breakpoint" do
  action :break
end

# Testing nodes
node.default["food"] = "Burger"
node.default["animal"] = "Bird"
node.default["weather"] = "Sunny"

breakpoint "middle breakpoint" do
  action :break
end

node.default["city"] = "San Francisco"
node.default["state"] = "California"
node.default["weather"] = "Rain"
node.default["country"] = "USA"

# chef_run.step
if node['platform_family'] == 'windows' then
  powershell_script "print current directory" do
    code <<-EOH
    $pwd
    EOH
    action :run
  end
elsif node['platform_family'] == 'rhel' then
  bash "state current directory" do
    code <<-EOH
    pwd
    echo "The weather in node['city'], node['state'], node['country'] is node['weather']."
    EOH
    action :run
  end
end 

breakpoint "after breakpoint" do
  action :break
end

Chef::Log.warn(node["weather"])