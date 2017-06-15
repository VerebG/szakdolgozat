require 'spec_helper'
describe 'szakdolgozat' do
  context 'with default values for all parameters' do
    it { should contain_class('szakdolgozat') }
  end
end
