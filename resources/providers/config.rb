
# Cookbook:: rb-postfix
#
# Provider:: config
#

action :add do
  begin
    user = new_resource.user

    dnf_package 'postfix' do
      action :upgrade
      flush_cache[:before]
    end

    execute 'create_user' do
      command "/usr/sbin/useradd -r #{user}"
      ignore_failure true
      not_if "getent passwd #{user}"
    end

    template '/etc/postfix/main.cf' do
      source 'main.cf.erb'
      owner 'root'
      group 'root'
      mode '0644'
      ignore_failure true
      cookbook 'rb-postfix'
      notifies :restart, 'service[postfix]', :delayed
    end

    service 'postfix' do
      service_name 'postfix'
      ignore_failure true
      supports status: true, reload: true, restart: true, enable: true
      action [:start, :enable]
    end

    Chef::Log.info('rb-postfix cookbook has been processed')
  rescue => e
    Chef::Log.error(e.message)
  end
end

action :remove do
  begin

    service 'postfix' do
      supports stop: true
      action :stop
    end

    Chef::Log.info('rb-postfix cookbook has been processed')
  rescue => e
    Chef::Log.error(e.message)
  end
end
