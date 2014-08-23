git-server Cookbook
========================
Installs a simple, SSH based Git server.  For example, if my server hostname is `git.remoteserver.com` and I created the repository `git-is-awesome`, I can use it as follows:

```bash
> git remote add origin git@git.remoteserver.com:git-is-awesome.git
> git push origin master
> git pull origin master
```

Requirements
------------

#### Chef

Tested on Chef 11.6.2.

#### Platform

Currently only tested on Ubuntu 14.04.  Please provide PR's for any other distros you wish to support.

* Ubuntu

#### Cookbooks
The following external cookbook dependencies are required for git-server:

* git
* users


Attributes
----------

#### git-server::repositories
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['git-server']['repositories']</tt></td>
    <td>Array of strings</td>
    <td>Names of bare repositories to initialize</td>
    <td><tt>[]</tt></td>
  </tr>
</table>

Usage
-----

####  git-server::default

Include `git-server` in your node's `run_list` and a list of:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[git-server]"
  ],
}
```
Configure any repositories you want to be created:

```ruby
default_attributes(
  "git-server" => {
    "repositories" => ['chef-brianhartsock']
})
```

Include SSH Keys for any users in the `users` databag:

```json
{
  "id": "username",
  "ssh_keys": "<insert ssh key here>",
  ...
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Brian Hartsock
