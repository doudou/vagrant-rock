BASE_DIR = File.expand_path(File.dirname(__FILE__))
CHEF_DIR = File.join(BASE_DIR, 'chef')

ENV['PATH'] = "/opt/chefdk/bin:#{ENV['PATH']}"

require_relative 'setup-local'

def setup_vagrant(config)
    config.berkshelf.enabled = true
    config.berkshelf.berksfile_path = File.join(CHEF_DIR, 'Berksfile')

    if Vagrant.has_plugin?('vagrant-cachier')
        config.cache.scope = :box
        #config.cache.enable :gem
        config.cache.synced_folder_opts = Hash[
            type: '9p',
            accessmode: 'mapped',
            owner: 'client'
        ]
    end

    setup_vagrant_local(config)
end

def setup_box(config, name, box)
    setup_box_local(config, name, box)
end

def setup_chef(config, name, box, chef)
    chef.data_bags_path    = File.join(CHEF_DIR, "data_bags")
    # Note: cookbooks are managed by berkshelf
    chef.environments_path = File.join(CHEF_DIR, "environments")
    chef.roles_path        = File.join(CHEF_DIR, "roles")
    setup_chef_local(config, name, box, chef)
end
