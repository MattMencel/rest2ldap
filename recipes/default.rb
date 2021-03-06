#
# Cookbook Name:: rest2ldap
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

include_recipe 'tomcat'

tomcat_svc = 'tomcat' + node['tomcat']['base_version'].to_s

remote_file node['tomcat']['webapp_dir'] + '/' + node['rest2ldap']['name'] + '.war' do
  source node['rest2ldap']['url']
  notifies :restart, 'service[' + tomcat_svc + ']', :immediately
end

template node['tomcat']['webapp_dir'] + '/' + node['rest2ldap']['name'] + '/opendj-rest2ldap-servlet.json' do
  owner node['tomcat']['user']
  group node['tomcat']['group']
  mode '0640'
  notifies :restart, 'service[' + tomcat_svc + ']', :delayed
end

service tomcat_svc do
  supports status: true, restart: true
  action :nothing
end
