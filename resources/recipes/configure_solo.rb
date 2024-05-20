#
# Cookbook:: rb-postfix
# Recipe:: configure_solo
#
# Copyright:: 2017-2024 Chef Software, Inc.
#
# All rights reserved - Do Not Redistribute
#

rb_postfix_config 'config' do
  action [:add]
end
