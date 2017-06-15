# Class: timezone::params
# ===========================
#
# Parameters and platform specific parameter preparation for `::timezone` class.
#
# Parameters
# ----------
#
# * `timezone`
# Name of the desired timezone. By default we assume "Etc/UTC" here. Available
# timezones: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
#
# * `hw_utc`
# Is the hardware clock set to UTC? By default we assume `true`
#
# * `package_ensure`
# Should the package be 'absent', 'present' or its 'latest' version? Defaults to
# 'present'.
#
# * `package_install_options`
# Pass package specific options. Defaults to: empty.
#
# * `manage_package`
# Manage timezone packages automatically. Defaults to `true`.
#
# * `package_name`
# Package name to use. Defaults to operating system default package, e.g. to
# 'tzdata' on CentOS.
#
# * `package_provider`
# Package provider to use. Defaults to operating system default provider,
# e.g. 'apt' on Debian.
#
# * `zoneinfo_dir`
# Path to directory where timezone information is stored. Defaults to operating
# system specific path.
#
# * `localtime_file`
# The file which will be symlinked or a copy of the actual timezone file in the
# timezone information directory. Defaults to operating system default path.
#
# * `localtime_file_type`
# Determines if `localtime_file` will be a `file` or `link`. Based on `osfamily`
#
# * `timezone_file`
# Some operating systems stored timezone in this file with additional settings.
# This is set per operating system family, and can be overriden.
#
# * `timezone_file_template`
# If using a `timezone_file`, a template for the files' content can be used.
# This is set per operating system family, and can be overriden.
#
# * `timezone_file_comments`
# If the timezone file supports comments.
# This is set per operating system family, and can be overriden.
#
# * `timezone_update`
# Signals if an update to the timezone requires execution of an update command.
# Either is `false`, or contains the update command to be executed.
# This is set per operating system family, and can be overriden.
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
class timezone::params {
  $timezone                = 'Etc/UTC'
  $hw_utc                  = true
  $package_ensure          = 'present'
  $package_install_options = []
  $manage_package          = true

  case $::osfamily {
    'Debian': {
      $package_name           = [ 'tzdata' ]
      $package_provider       = 'apt'
      $zoneinfo_dir           = '/usr/share/zoneinfo/'
      $localtime_file         = '/etc/localtime'
      $localtime_file_type    = 'file'
      $timezone_file          = '/etc/timezone'
      $timezone_file_template = 'timezone/timezone.erb'
      $timezone_file_comments = false
      $timezone_update        = 'dpkg-reconfigure -f noninteractive tzdata'
    }
    'RedHat': {
      $package_name           = [ 'tzdata' ]
      $package_provider       = 'yum'
      $zoneinfo_dir           = '/usr/share/zoneinfo/'
      $localtime_file         = '/etc/localtime'
      case $::operatingsystemmajrelease {
        '7': {
          $localtime_file_type    = 'link'
          $timezone_file          = false
          $timezone_file_template = false
          $timezone_file_comments = false
          $timezone_update        = "timedatectl set-timezone ${timezone}"
        }
        default: {
          $localtime_file_type    = 'file'
          $timezone_file          = '/etc/sysconfig/clock'
          $timezone_file_template = 'timezone/clock.erb'
          $timezone_file_comments = false
          $timezone_update        = 'tzdata-update'
        }
      }
    }
    default: {
      case $::operatingsystem {
        default: {
          fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
        }
      }
    }
  }
}
