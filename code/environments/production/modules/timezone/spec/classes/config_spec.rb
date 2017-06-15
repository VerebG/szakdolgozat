require 'spec_helper'

describe 'timezone::config', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end
      options = os_specific_options(facts)

      context 'with all defaults when :osfamily == "Debian"' do
        let :params do
          {
            timezone: options[:default_timezone],
            hw_utc: false,
            package_ensure: 'present',
            zoneinfo_dir: options[:zoneinfo_dir],
            localtime_file: options[:localtime_file],
            localtime_file_type: options[:localtime_file_type],
            timezone_file: options[:timezone_file],
            timezone_file_template: options[:timezone_file_template],
            timezone_file_comments: options[:timezone_file_comments],
            timezone_update: options[:timezone_update]
          }
        end

        if facts[:osfamily] == 'Debian'
          it do
            is_expected.to contain_file(options[:localtime_file]).with(
              ensure: options[:localtime_file_type],
              source: 'file://' + options[:zoneinfo_dir] + options[:default_timezone]
            )
          end
          it { is_expected.to contain_file(options[:timezone_file]).with_content(%r{Etc/UTC}) }
          it { is_expected.to contain_exec('update_timezone').with_command(%r{dpkg-reconfigure -f noninteractive tzdata}) }
        end
      end

      context 'with all defaults when RHEL <= 6' do
        let :params do
          {
            timezone: options[:default_timezone],
            hw_utc: false,
            package_ensure: 'present',
            zoneinfo_dir: options[:zoneinfo_dir],
            localtime_file: options[:localtime_file],
            localtime_file_type: options[:localtime_file_type],
            timezone_file: options[:timezone_file],
            timezone_file_template: options[:timezone_file_template],
            timezone_file_comments: options[:timezone_file_comments],
            timezone_update: options[:timezone_update]
          }
        end

        if facts[:osfamily] == 'RedHat' && facts[:operatingsystemmajrelease] <= '6'
          it do
            is_expected.to contain_file(options[:localtime_file]).with(
              ensure: options[:localtime_file_type],
              source: 'file://' + options[:zoneinfo_dir] + options[:default_timezone]
            )
          end
          it { is_expected.to contain_file(options[:timezone_file]).with_content(%r{ZONE="Etc/UTC"}) }
          it { is_expected.to contain_exec('update_timezone').with_command('tzdata-update') }
        end
      end

      context 'with all defaults when RHEL >= 7' do
        let :params do
          {
            timezone: options[:default_timezone],
            hw_utc: false,
            package_ensure: 'present',
            zoneinfo_dir: options[:zoneinfo_dir],
            localtime_file: options[:localtime_file],
            localtime_file_type: options[:localtime_file_type],
            timezone_file: options[:timezone_file],
            timezone_file_template: options[:timezone_file_template],
            timezone_file_comments: options[:timezone_file_comments],
            timezone_update: options[:timezone_update]
          }
        end

        if facts[:osfamily] == 'RedHat' && facts[:operatingsystemmajrelease] >= '7'
          it do
            is_expected.to contain_file(options[:localtime_file]).with(
              ensure: options[:localtime_file_type],
              target: options[:zoneinfo_dir] + options[:default_timezone]
            )
          end
          it { is_expected.not_to contain_file(options[:timezone_file]).with_ensure('file') }
          it { is_expected.to contain_exec('update_timezone').with_command('timedatectl set-timezone Etc/UTC') }
        end
      end

      context 'with package_ensure => "absent"' do
        let :params do
          {
            timezone: 'Europe/Berlin',
            hw_utc: false,
            package_ensure: 'absent',
            zoneinfo_dir: options[:zoneinfo_dir],
            localtime_file: options[:localtime_file],
            localtime_file_type: options[:localtime_file_type],
            timezone_file: options[:timezone_file],
            timezone_file_template: options[:timezone_file_template],
            timezone_file_comments: options[:timezone_file_comments],
            timezone_update: options[:timezone_update]
          }
        end

        it { is_expected.to contain_file(options[:localtime_file]).with_ensure('absent') }
      end

      context 'when timezone => "Europe/Berlin"' do
        let :params do
          {
            timezone: 'Europe/Berlin',
            hw_utc: false,
            package_ensure: 'present',
            zoneinfo_dir: options[:zoneinfo_dir],
            localtime_file: options[:localtime_file],
            localtime_file_type: options[:localtime_file_type],
            timezone_file: options[:timezone_file],
            timezone_file_template: options[:timezone_file_template],
            timezone_file_comments: options[:timezone_file_comments],
            timezone_update: options[:timezone_update]
          }
        end

        if options[:localtime_file_type] == 'file'
          it do
            is_expected.to contain_file(options[:localtime_file]).with(
              ensure: options[:localtime_file_type],
              source: 'file://' + options[:zoneinfo_dir] + 'Europe/Berlin'
            )
          end
        end
        if options[:localtime_file_type] == 'link'
          it do
            is_expected.to contain_file(options[:localtime_file]).with(
              ensure: options[:localtime_file_type],
              target: options[:zoneinfo_dir] + 'Europe/Berlin'
            )
          end
        end
      end
    end
  end
end
