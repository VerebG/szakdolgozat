require 'spec_helper'
describe 'filesynchronization' do
  context 'with default values for all parameters' do
    it { should contain_class('filesynchronization') }
  end
end
