require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
require 'coveralls'
require 'simplecov'
require 'simplecov-console'
include RspecPuppetFacts

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::Console,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  track_files 'lib/**/*.rb'
  add_filter '/spec'
  add_filter '/vendor'
  add_filter '/.vendor'
end

RSpec.configure do |c|
  default_facts = {
    puppetversion: Puppet.version,
    facterversion: Facter.version
  }
  default_facts.merge!(YAML.safe_load(File.read(File.expand_path('../default_facts.yml', __FILE__)))) if File.exist?(File.expand_path('../default_facts.yml', __FILE__))
  default_facts.merge!(YAML.safe_load(File.read(File.expand_path('../default_module_facts.yml', __FILE__)))) if File.exist?(File.expand_path('../default_module_facts.yml', __FILE__))
  c.default_facts = default_facts
end

require 'spec_helper_methods'
