#
# Cookbook Name:: chef_debug
# Recipe:: debug
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "chef_debug::debug_#{node["platform_family"]}"

# !Code below for debug testing!

# Testing nodes
node.default["food"]["topping"] = "Ketchup"
node.default["color"] = "Yellow"
node.default["animal"] = "Bird"
node.default["city"] = "San Francisco"
node.default["state"] = "California"

# $$ run_chef
# $$ chef_run

breakpoint "before breakpoint" do
  action :break
end

# $$ chef_run.step
if node["platform_family"] == "windows" then
  powershell_script "print current directory" do
    code <<-EOH
    $pwd
    EOH
    action :run
  end
elsif node["platform_family"] == "rhel" then
  bash "state current directory" do
    code "pwd"
    action :run
  end
end 

# $$ chef_run.rewind
# $$ chef_run.resume

breakpoint "after breakpoint" do
  action :break
end

Chef::Log.warn(node["state"])