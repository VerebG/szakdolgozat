require 'spec_helper'

describe 'timezone', type: :class do
  context 'on non supported operating systems' do
    let(:facts) { { osfamily: 'foo', operatingsystem: 'bar' } }

    it 'fails' do
      is_expected.to compile.and_raise_error(%r{Unsupported platform: foo/bar})
    end
  end

  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end
      options = os_specific_options(facts)
      context 'with all defaults' do
        it { is_expected.to contain_class('timezone') }
        it { is_expected.to contain_class('timezone::params') }
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_anchor('timezone::begin') }
        it { is_expected.to contain_anchor('timezone::end') }
        it { is_expected.to contain_package(options[:package]).with_ensure('present') }
        it { is_expected.to contain_package(options[:package]).with_install_options([]) }
        it { is_expected.to contain_class('timezone::install').that_comes_before('Class[timezone::config]') }
        it { is_expected.to contain_class('timezone::config') }
        it do
          is_expected.to contain_file(options[:localtime_file]).with(
            ensure: options[:localtime_file_type]
          )
        end
      end

      context 'when custom package_name is set' do
        let :params do
          {
            package_ensure: 'present',
            package_name: 'timezone-awesomerrr',
            package_provider: 'apt',
            package_install_options: [],
            manage_package: true
          }
        end
        it { is_expected.to contain_package('timezone-awesomerrr').with_ensure('present') }
      end

      context 'when manage_package is false' do
        let :params do
          {
            manage_package: false
          }
        end
        it { is_expected.not_to contain_package(options[:package]) }
      end

      context 'when manage_package is true' do
        let(:params) { { manage_package: true } }
        it { is_expected.to contain_package(options[:package]).with_ensure('present') }
      end

      context 'setting timezone::install::package_install_options to a valid array' do
        let :params do
          { package_install_options: ['--nogpgcheck'] }
        end

        it { is_expected.to contain_package(options[:package]).with_install_options(['--nogpgcheck']) }
      end

      context 'setting timezone::install::package_install_options to an invalid value (non-array)' do
        let :params do
          { package_install_options: 'not_an_array' }
        end

        it 'fails' do
          expect do
            is_expected.to contain_class('timezone')
          end.to raise_error(Puppet::Error, %r{is not an Array})
        end
      end
    end
  end
end
