class szakdolgozat::nagios::generic {

  file {
    default: * => {
      ensure  => file,
      owner   => nagios,
      group   => nagios,
    };
    "${::szakdolgozat::nagios_default_working_directory}/objects/24x7.cfg":
      require => Nagios_timeperiod['24x7'];
    "${::szakdolgozat::nagios_default_working_directory}/objects/daytime.cfg":
      require => Nagios_timeperiod['daytime'];
    "${::szakdolgozat::nagios_default_working_directory}/objects/worktime.cfg":
      require => Nagios_timeperiod['worktime'];
    "${::szakdolgozat::nagios_default_working_directory}/objects/generic-service.cfg":
      require => Nagios_service['generic-service'];
    "${::szakdolgozat::nagios_default_working_directory}/objects/generic-host.cfg":
      require => Nagios_host['generic-host'];
  }

  nagios_timeperiod {
    '24x7':
      alias                        => '24 Hours A Day, 7 Days A Week',
      monday                       => '00:00-24:00',
      tuesday                      => '00:00-24:00',
      wednesday                    => '00:00-24:00',
      thursday                     => '00:00-24:00',
      friday                       => '00:00-24:00',
      saturday                     => '00:00-24:00',
      sunday                       => '00:00-24:00',
      target                       => "${::szakdolgozat::nagios_default_working_directory}/objects/24x7.cfg";
    'daytime':
      alias                        => '8 AM to 8 PM, 7 days a week',
      monday                       => '08:00-20:00',
      tuesday                      => '08:00-20:00',
      wednesday                    => '08:00-20:00',
      thursday                     => '08:00-20:00',
      friday                       => '08:00-20:00',
      saturday                     => '08:00-20:00',
      sunday                       => '08:00-20:00',
      target                       => "${::szakdolgozat::nagios_default_working_directory}/objects/daytime.cfg";
    'worktime':
      alias                        => '8 AM to 6 PM, 5 days a week',
      monday                       => '08:00-18:00',
      tuesday                      => '08:00-18:00',
      wednesday                    => '08:00-18:00',
      thursday                     => '08:00-18:00',
      friday                       => '08:00-18:00',
      target                       => "${::szakdolgozat::nagios_default_working_directory}/objects/worktime.cfg";
  }

  nagios_host {
    'generic-host':
      notifications_enabled        => 1,
      event_handler_enabled        => 1,
      flap_detection_enabled       => 1,
      process_perf_data            => 1,
      retain_status_information    => 1,
      retain_nonstatus_information => 1,
      max_check_attempts           => 3,
      check_command                => "check-host-alive",
      notification_interval        => 86400,
      notification_period          => "24x7",
      notification_options         => "d,u,r,f,s",
      register                     => 0,
      contact_groups               => 'all',
      target                       => "${::szakdolgozat::nagios_default_working_directory}/objects/generic-host.cfg";
  }

  nagios_service {
    'generic-service':
      active_checks_enabled        => 1,
      passive_checks_enabled       => 1,
      parallelize_check            => 1,
      obsess_over_service          => 1,
      check_freshness              => 0,
      notifications_enabled        => 1,
      event_handler_enabled        => 1,
      flap_detection_enabled       => 1,
      process_perf_data            => 1,
      retain_status_information    => 1,
      retain_nonstatus_information => 1,
      max_check_attempts           => 3,
      check_interval               => 5,
      retry_interval               => 1,
      notification_interval        => 86400,
      notification_options         => "w,u,c,r,f,s",
      check_period                 => "24x7",
      register                     => 0,
      contact_groups               => 'all',
      target                       => "${::szakdolgozat::nagios_default_working_directory}/objects/generic-service.cfg";
  }

  Nagios_host {
    contact_groups => 'all'
  }
  Nagios_service {
    contact_groups => 'all'
  }

}
