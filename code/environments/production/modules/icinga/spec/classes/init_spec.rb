require 'spec_helper'
describe 'icinga' do
  let :facts do
    {
        :osfamily => 'Debian'
    }
  end
  it {
    should contain_service('icinga2').with( { 'name' => 'icinga2' } )
  }
end
