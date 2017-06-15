require 'spec_helper'

describe 'timezone::install', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end
      options = os_specific_options(facts)

      context 'with package_ensure => "absent"' do
        let :params do
          {
            package_ensure: 'absent',
            package_name: options[:package],
            package_provider: options[:package_provider],
            package_install_options: [],
            manage_package: true,
            timezone: options[:default_timezone]
          }
        end

        it { is_expected.to contain_package(options[:package]).with_ensure('present') }
      end

      context 'with apt provider and :osfamily => "Debian"' do
        if facts[:osfamily] == 'Debian'
          let :params do
            {
              package_ensure: 'present',
              package_name: 'tzdata',
              package_provider: 'apt',
              package_install_options: [],
              manage_package: true,
              timezone: options[:default_timezone]
            }
          end

          it { is_expected.to contain_debconf('update_debconf area') }
          it { is_expected.to contain_debconf('update_debconf zone') }
          it { is_expected.to contain_package('tzdata').with(provider: 'apt') }
        end
      end

      context 'with yum provider and :osfamily => "RedHat"' do
        if facts[:osfamily] == 'RedHat'
          let :params do
            {
              package_ensure: 'present',
              package_name: 'tzdata',
              package_provider: 'yum',
              package_install_options: [],
              manage_package: true,
              timezone: options[:default_timezone]
            }
          end

          it { is_expected.to contain_package('tzdata').with(provider: 'yum') }
        end
      end
    end
  end
end
