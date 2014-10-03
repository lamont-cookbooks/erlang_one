#
# Cookbook Name:: erlang_one
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

include_recipe 'build-essential'

raise "cookbook only supports debian/ubuntu" unless node['platform_family'] == "debian"

%w{ libncurses5-dev openssl libssl-dev }.each do |pkg|
  package pkg
end

erlang_version = node['erlang']['source']['version']

erlang_uri = node['erlang']['source']['uri'] ||
  "http://erlang.org/download/otp_src_#{erlang_version}.tar.gz"

erlang_checksum = node['erlang']['source']['checksum']

log "using #{erlang_uri} for source download"

bash "install-erlang #{erlang_version}" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar -xzf otp_src_#{erlang_version}.tar.gz
    (cd otp_src_#{erlang_version} && ./configure && make && make install)
  EOH
  action :nothing
  not_if "erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().' -noshell | grep #{erlang_version}"
end

remote_file File.join(Chef::Config[:file_cache_path], "otp_src_#{erlang_version}.tar.gz") do
  source erlang_uri
  owner 'root'
  mode 0644
  checksum erlang_checksum
  notifies :run, "bash[install-erlang #{erlang_version}]", :immediately
end
