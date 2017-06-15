# Class: timezone
# ===========================
#
# Manages timezone settings on various Linux/BSD operating systems.
#
# Parameters
# ----------
#
# * `timezone`
# Name of the desired timezone. By default we assume "UTC" here. Available
# timezones: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
#
# * `hw_utc`
# Is the hardware clock set to UTC? By default we assume `true`
#
# Examples
# --------
#
# @example
#    class { 'timezone':
#      timezone => 'America/New_York',
#      hw_utc   => false,
#    }
#
# Authors
# -------
#
# Daniel S. Reichenbach <daniel@kogitoapp.com>
#
# Copyright
# ---------
#
# Copyright 2016 Daniel S. Reichenbach <https://kogitoapp.com>
#
class timezone (
  $timezone                = $timezone::params::timezone,
  $hw_utc                  = $timezone::params::hw_utc,

  $package_ensure          = $timezone::params::package_ensure,
  $package_name            = $timezone::params::package_name,
  $package_provider        = $timezone::params::package_provider,
  $package_install_options = $timezone::params::package_install_options,
  $manage_package          = $timezone::params::manage_package,

  $zoneinfo_dir            = $timezone::params::zoneinfo_dir,
  $localtime_file          = $timezone::params::localtime_file,
  $localtime_file_type     = $timezone::params::localtime_file_type,
  $timezone_file           = $timezone::params::timezone_file,
  $timezone_file_template  = $timezone::params::timezone_file_template,
  $timezone_file_comments  = $timezone::params::timezone_file_comments,
  $timezone_update         = $timezone::params::timezone_update,
  ) inherits timezone::params {

  class { '::timezone::install':
    package_install_options => $package_install_options,
  }

  class { '::timezone::config': }

  anchor { 'timezone::begin': }
  anchor { 'timezone::end': }

  Anchor['timezone::begin'] ->
  Class['timezone::install'] ->
  Class['timezone::config']
}
