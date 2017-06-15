def os_specific_options(facts)
  case facts[:osfamily]
  when 'RedHat'
    case facts[:operatingsystemmajrelease]
    when '7'
      {
        package: 'tzdata',
        package_provider: 'yum',
        default_timezone: 'Etc/UTC',
        zoneinfo_dir: '/usr/share/zoneinfo/',
        localtime_file: '/etc/localtime',
        localtime_file_type: 'link',
        timezone_file: '/etc/sysconfig/clock',
        timezone_file_template: '',
        timezone_file_comments: true,
        timezone_update: 'timedatectl set-timezone Etc/UTC'
      }
    else
      {
        package: 'tzdata',
        package_provider: 'yum',
        default_timezone: 'Etc/UTC',
        zoneinfo_dir: '/usr/share/zoneinfo/',
        localtime_file: '/etc/localtime',
        localtime_file_type: 'file',
        timezone_file: '/etc/sysconfig/clock',
        timezone_file_template: 'timezone/clock.erb',
        timezone_file_comments: true,
        timezone_update: 'tzdata-update'
      }
    end
  when 'Debian'
    {
      package: 'tzdata',
      package_provider: 'apt',
      default_timezone: 'Etc/UTC',
      zoneinfo_dir: '/usr/share/zoneinfo/',
      localtime_file: '/etc/localtime',
      localtime_file_type: 'file',
      timezone_file: '/etc/timezone',
      timezone_file_template: 'timezone/timezone.erb',
      timezone_file_comments: false,
      timezone_update: 'dpkg-reconfigure -f noninteractive tzdata'
    }
  else
    {
      package: 'timezone',
      package_provider: 'awesomerrr',
      default_timezone: 'Etc/UTC',
      zoneinfo_dir: '/usr/share/zoneinfo/',
      localtime_file: '/etc/localtime',
      localtime_file_type: 'file',
      timezone_file: '/etc/timezone',
      timezone_file_template: 'timezone/timezone.erb',
      timezone_file_comments: true,
      timezone_update: false
    }
  end
end
