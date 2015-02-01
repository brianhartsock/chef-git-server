#
# Cookbook Name:: git-server
# Recipe:: default
#
#

include_recipe 'git'

# Create git user on server
user "git" do
  supports :manage_home => true
  comment "Git user"
  home "/home/git"
  shell "/usr/bin/git-shell"
end

directory "/home/git/.ssh" do
  user "git"
  group "git"
  mode "700"
end

# Pulls all SSH Keys out of users databag and adds to the git user
# authorized_keys.  See users cookbook for details"
users = data_bag('users')
ssh_keys = ''
users.each do |username|
  user = data_bag_item('users', username)
  Array(user['ssh_keys']).each do |ssh_key|
    ssh_keys << ssh_key + "\n"
  end
end

file "/home/git/.ssh/authorized_keys" do
  owner "git"
  group "git"
  mode "600"
  content ssh_keys
end

# Setup repositories defined as node attributes
node['git-server']['repositories'].each do |repository_name|
  execute "git init --bare #{repository_name}.git" do
    user "git"
    group "git"
    cwd "/home/git"
    creates "/home/git/#{repository_name}.git"
  end
end
