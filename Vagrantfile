script = %Q{
PUPPET_PATH=/opt/puppetlabs/bin
PUPPET_MODULE_PATH=$($PUPPET_PATH/puppet config print modulepath)
PUPPET_MODULE_PATH=$PUPPET_MODULE_PATH:/vagrant/puppet
MODULES=(stankevich-python jfryman-nginx puppetlabs-postgresql)
for module in "${MODULES[@]}"; do
  sudo $PUPPET_PATH/puppet module install $module
done

sudo $PUPPET_PATH/puppet apply --modulepath=$PUPPET_MODULE_PATH \
  /vagrant/puppet/environments/test.pp
}


Vagrant.configure("2") do |config|
  config.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"
  config.vm.synced_folder '/home/aaron/jobs-economy/backend', '/home/jobseconomy/backend'
  config.vm.provision :shell, inline: script
  # config.vm.provision "puppet" do |puppet|
  #   puppet.manifest_file = "env/test.pp"
  #   puppet.manifests_path = 'puppet/'
  #   puppet.module_path = 'puppet'
  #   puppet.facter = {
  #     "jobseconomy_source" => '/srv/jobseconomy'
  #   }
  # end
end
