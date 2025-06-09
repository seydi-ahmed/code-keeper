Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

  # Provision Ansible local playbook
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/deploy_gitlab.yml"
  end
end
