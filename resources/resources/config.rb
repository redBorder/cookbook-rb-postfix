unified_mode true

# Cookbook:: rb-postfix
#
# Resource:: config
#

actions :add, :remove
default_action :add

attribute :user, kind_of: String, default: 'postfix'
