require 'beaker-rspec'

install_puppet_agent_on hosts, {} unless ENV['BEAKER_provision'] == 'no'

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    puppet_module_install(source: proj_root, module_name: 'timezone')
    hosts.each do |host|
      on host, puppet('module', 'install', 'puppetlabs-stdlib'), acceptable_exit_codes: [0]
      on host, puppet('module', 'install', 'puppet-yum'), acceptable_exit_codes: [0]
      on host, puppet('module', 'install', 'puppetlabs-apt'), acceptable_exit_codes: [0]
      on host, puppet('module', 'install', 'stm-debconf'), acceptable_exit_codes: [0]
    end
  end
end
