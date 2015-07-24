rock_utility_path =
    ENV['ROCK_UTILITY_PATH'] || File.join(Dir.home, 'dev', 'rock')
vagrant_vm_path = File.expand_path(File.dirname(__FILE__))

Vagrant.configure("2") do |config|
    config.vm.define :rock_toolchain_devel do |bb|
        bb.vm.box = "ubuntu/trusty64"
        bb.vm.provider :libvirt do |libvirt|
            libvirt.cpus = 4
            libvirt.memory = 4096
        end
        bb.vm.synced_folder File.join(rock_utility_path, "cache", "archives"), "/opt/rock/cache/archives", type: '9p'
        bb.vm.synced_folder File.join(rock_utility_path, "cache", "git"), "/opt/rock/cache/git", type: '9p'
        bb.vm.synced_folder File.join(rock_utility_path, "autoproj"), "/opt/rock/autoproj", type: '9p'
        bb.vm.synced_folder File.join(rock_utility_path, "autobuild"), "/opt/rock/autobuild", type: '9p'
        # There are issues with 9p shares w.r.t. permissions (TL;DR is that it's
        # hard to get a R/W share). Use rsync for the cache
        bb.vm.synced_folder File.join(rock_utility_path, "cache", "gems"), "/opt/rock/cache/gems"

        bb.vm.provision "file", source: File.join(vagrant_vm_path, 'autoprojrc'), destination: '/home/vagrant/.autoprojrc'
        bb.vm.provision "file", source: File.join(rock_utility_path, 'autoproj', 'bin', 'autoproj_bootstrap'),
            destination: '/home/vagrant/autoproj_bootstrap'
        bb.vm.provision "file", source: '~/.gitconfig', destination: '/home/vagrant/.gitconfig'
        bb.vm.provision 'shell', path: File.join(vagrant_vm_path, 'initial_bootstrap.sh'), privileged: false
    end
    config.vm.provider :libvirt do |libvirt|
    end
end
