require 'spec_helper'
describe 'icinga' do
  context 'with default values for all parameters' do
    it { should contain_class('icinga') }
  end
end
