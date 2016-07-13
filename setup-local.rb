CACHE_DIR = '/home/doudou/dev/rock/cache'

BOXES = Hash[
    'ubuntu-14.04' => 'ubuntu/trusty64',
    'ubuntu-15.04' => 'ubuntu/vivid64',
    'ubuntu-15.10' => 'ubuntu/wily64',
    'ubuntu-16.04' => 'ubuntu/xenial64'
]

def setup_vagrant_local(config)
    config.vm.synced_folder '/home/doudou/dev/gems/autoproj', '/opt/gems/autoproj',
        type: '9p', accessmode: 'mapped', owner: 'client', user: 'flat_fish'
    config.vm.synced_folder '/home/doudou/dev/gems/autobuild', '/opt/gems/autobuild',
        type: '9p', accessmode: 'mapped', owner: 'client', user: 'flat_fish'
    config.vm.synced_folder CACHE_DIR, '/opt/rock/cache',
        type: '9p', accessmode: 'mapped', owner: 'client', user: 'flat_fish'
end

def setup_box_local(config, name, box)
    osname, rock_flavor, ruby_version = name.split(':')

    box.vm.box = BOXES.fetch(osname)
end
def setup_chef_local(config, name, box, chef)
    json = (chef.json || Hash.new)
    rock = (json['rock'] ||= Hash.new)
    rock['cache_dir'] = CACHE_DIR
    chef.json = json
end
