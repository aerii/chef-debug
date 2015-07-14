# chef_debug

Chef Zero Debug
===============

Description
-----------
The Chef Zero shell can be used for debugging Chef code. This cookbook automatically provides the initial configurations necessary to get the shell running on temporary Linux-based and Windows-based virtual machines used in reproducible/repeatable environments for virtual boxes, such as VirtualBox. The Wiki contains more detailed information about settings and configurations.

The shell offers close inspection of the code, by loading specific recipes in the run list. The default recipe is `recipe[chef_debug::default]`. The breakpoint resource can be used to break in the recipe at specific locations. The syntax for a breakpoint resource is:

```ruby
breakpoint 'name' do
  action :break
end
```

Problem Scenario
----------------
Solving a logical error on a Linux CentOS platform by stepping through the code line-by-line.
The node["weather"] says that it is "Rain" when it should be "Sunny".

Solving step-by-step
--------------------
1. Enter vagrant through kitchen: `kitchen login` <br>
1. Change to root: `sudo su -` <br>
1. Initialize the debugging shell: `debug.sh` <br>
1. Inspect the platform: `node["fqdn"]` <br>
   The output shows that it is CentOS **=> "default-centos-66"**. <br>
1. Inspect the weather node: `node["weather"]` <br>
   The output shows that it is **=> "Rain"**. <br>
1. Initiate the chef-client: `run_chef` <br>
   The program is run until the first breakpoint, at chef_debug::debug line 11. <br>
1. To step through the code: `chef_run.step` <br>
   The program steps to the next breakpoint, at chef_debug::debug line 20. <br>
   The output is **=> 6** because it skipped six lines. <br>
1. To resume the code: `chef_run.resume` <br>
   The output shows that the node["weather"] was set twice. <br>
   On line 18 it was set to "Sunny" but the value was overwritten on line 26 to "Rain". <br>
1. Comment out line 26 in chef_debug::debug.rb using: `#`
1. To exit the debugging shell: `exit`
1. Before exiting vagrant, check if chef-zero is still running: `ps aux | grep chef-zero` <br>
   The first line in the output shows that chef-zero is still running: <br>
   **root      7025  ?        Sl   01:29   0:00 /opt/chef/embedded/bin/ruby /opt/chef/embedded/bin/chef-zero -d<br>**
   **root      7283  pts/0    S+   01:36   0:00 grep chef-zero**
1. To stop chef-zero: `stop_debug.sh` <br>
   This is necessary in order to re-converge kitchen for Linux platforms.
1. Running the command again, shows that chef-zero daemon has stopped: `ps aux | grep chef-zero` <br>
   **root   7294  pts/0    S+   01:39   0:00 grep chef-zero**
1. To exit root/vagrant: `exit` <br>
1. Re-converge kitchen to update changes: `kitchen converge` <br>
1. Repeat and then node["weather"] should now be => "Sunny". <br>

Installation
------------
The Chef Zero shell is called as part of the debug.rb recipe, that calls debug_rhel.rb and debug_windows.rb respectively based on the platform.
The node["platform_family"] is called as a determinant.

Usage
-----
In Linux, to run the chef-zero shell as a daemon, run the bash command in root:
```ruby
  debug.sh
```

In Linux, to see if the chef-zero shell is running as a daemon in the background:
```ruby
  ps aux | grep chef
```

In Linux, to stop the chef-zero shell daemon, run the command:
```ruby
  stop_debug.sh
```

In Windows, to run the chef-zero shell in the background, run the batch command:
```ruby
  debug.ps1
```

In Windows, to stop the chef-zero shell, close the command prompt (optional: run the command):
```ruby
  stop_debug.ps1
```

### Valid Options
You may currently pass the following options to the initializer:

- `default` - default mode (chef >)  
- `attributes_mode` - run in attributes mode (chef:attributes >)
- `recipe_mode` - run in recipe mode (chef:recipe >)

Configuration Files
-------------------
- `knife.rb` - Used to specify the chef-repo-specific configuration details for knife (can be modified) 
- `client.rb` - Used to specify the configuration details for the chef-client (can be modified)
- `debug.sh` - In Linux, the bash file to initiate the debugging shell (can be modified)
- `stop_debug.sh` - In Linux, the bash file to terminate the running debugging shell (can be modified)
- `debug.ps1` - In Windows, the powershell file to initiate the debugging shell (can be modified)
- `stop_debug.ps1` - In Windows, the optional powershell file to terminate the debugging shell (can be modified; commented out)

### Relevant Recipes
- `debug.rb` - Used to determine the platform
- `debug_rhel.rb` - Used to run debugging for Linux-based platforms
- `debug_windows.rb` - Used to run debugging for Windows-based platforms

Step-by-step Commands
-------------------
Common commands to inspect the chef-zero shell environment:
```ruby
  (1) run_chef
  (2) chef_run
  (3) chef_run.step
  (4) chef_run.rewind
  (5) chef_run.resume
```

CLI (Command Line)
------------------
Common knife commands to check the local development environment:

      $ knife help
      $ knife user list
      $ knife environment list

### Help
Run `help` inside the shell to see a list of the supported commands:
```text
chef-shell Help
================================================================================
| Command                  | Description
================================================================================
| help                     | prints this help message
| version                  | prints information about chef
| recipe_mode              | switch to recipe mode
| attributes_mode          | switch to attributes mode
| run_chef                 | run chef using the current recipe
| chef_run                 | returns an object to control a paused chef run
| chef_run.resume          | resume the chef run
| chef_run.step            | run only the next resource
| chef_run.skip_back       | move back in the run list
| chef_run.skip_forward    | move forward in the run list
| reset                    | resets the current recipe
| become_node              | assume the identity of another node.
| echo                     | turns printout of return values on or off
| echo?                    | says if echo is on or off
| tracing                  | turns on or off tracing of execution. *verbose*
| tracing?                 | says if tracing is on or off
| ls                       | simple ls style command
| node                     | returns the current node (i.e., this host)
| ohai                     | pretty print the node's attributes
| edit                     | edit an object in your EDITOR
| clients                  | Find and edit API clients
| clients.all              | list all api clients
| clients.show             | load an api client by name
| clients.search           | search for API clients
| clients.transform        | edit all api clients via a code block and save them
| cookbooks                | Find and edit cookbooks
| cookbooks.all            | list all cookbooks
| cookbooks.show           | load a cookbook by name
| cookbooks.transform      | edit all cookbooks via a code block and save them
| nodes                    | Find and edit nodes via the API
| nodes.all                | list all nodes
| nodes.show               | load a node by name
| nodes.search             | search for nodes
| nodes.transform          | edit all nodes via a code block and save them
| roles                    | Find and edit roles via the API
| roles.all                | list all roles
| roles.show               | load a role by name
| roles.search             | search for roles
| roles.transform          | edit all roles via a code block and save them
| databags                 | Find and edit +databag_name+ via the api
| databags.all             | list all items in the data bag
| databags.show            | load a data bag item by id
| databags.search          | search for items in the data bag
| databags.transform       | edit all items via a code block and save them
| environments             | Find and edit environments via the API
| environments.all         | list all environments
| environments.show        | load an environment by name
| environments.search      | search for environments
| environments.transform   | edit all environments via a code block and save them
| api                      | A REST Client configured to authenticate with the API
================================================================================

Use help(:command) to get detailed help with individual commands
```
