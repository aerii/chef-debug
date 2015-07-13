# chef_debug

Chef Zero Debug
===============

Description
-----------
The Chef Zero shell can be used for debugging Chef code.

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

Installed Configuration Files
-----------------------------
- `knife.rb` - Used to specify the chef-repo-specific configuration details for knife (can be modified) 
- `client.rb` - Used to specify the configuration details for the chef-client (can be modified)
- `debug.sh` - In Linux, the bash file to initiate the debugging shell (can be modified)
- `stop_debug.sh` - In Linux, the bash file to terminate the running debugging shell (can be modified)
- `debug.ps1` - In Windows, the powershell file to initiate the debugging shell (can be modified)
- `stop_debug.ps1` - In Windows, the powershell file to terminate the running debugging shell (can be modified)

### Relevant Recipes
- `debug.rb` - Used to determine the platform
- `debug_rhel.rb` - Used to run debugging for Linux-based platforms
- `debug_windows.rb` - Used to run debugging for Windows-based platforms

Node Settings
-------------
```text
To turn on or off debugging (default is false):
  - node["chef_debug"]["debug"]["enabled"] = true/false

Default settings for nodes:
  - default["chef_debug"]["debug"]["service_name"] = 'chef-zero'
  - default["chef_debug"]["debug"]["log_level"] = ':info'
  - default["chef_debug"]["debug"]["log_location"] = 'STDOUT'
  - default["chef_debug"]["debug"]["node_name"] = 'admin'
  - default["chef_debug"]["debug"]["validation_client_name"] = 'chef-validator'
  - default["chef_debug"]["debug"]["chef_server_url"] = 'http://127.0.0.1:8889'

  Windows default:
  - default["chef_debug"]["debug"]["client_key"] = 'C:/Users/vagrant/AppData/Local/Temp/kitchen/client.pem'
  - default["chef_debug"]["debug"]["validation_key"] = 'C:/Users/vagrant/AppData/Local/Temp/kitchen/validation.pem'
  
  Linux default:
  - default["chef_debug"]["debug"]["client_key"] = '/tmp/kitchen/client.pem'
  - default["chef_debug"]["debug"]["validation_key"] = '/tmp/kitchen/validation.pem'
```

CLI (Command Line)
------------------
Common commands to check the local development environment:

      $ knife user list
      $ knife environment list

Additional Commands
-------------------
Common commands to inspect the chef-zero shell environment:
```ruby
  help(:command)
  nodes.all
  nodes.list
  node['fqdn']
  environments.all
```
Common commands to step inside the code:
```ruby
  (1) run_chef
  (2) chef_run
  (3) chef_run.step
  (4) chef_run.rewind
  (5) chef_run.resume
```

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