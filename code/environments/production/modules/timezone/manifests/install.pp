# Class: timezone::install
# ===========================
#
# Installs and configures and system package(s) required for setting the
# timezone settings.
#
# Parameters
# ----------
#
# * `package_ensure`
# Should the package be 'absent', 'present' or its 'latest' version?
#
# * `package_name`
# Package name to use.
#
# * `package_provider`
# Package provider to use.
#
# * `package_install_options`
# Pass package specific options.
#
# * `manage_package`
# Manage timezone packages automatically.
#
# * `timezone`
# Name of the desired timezone.
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
class timezone::install (
  $package_ensure          = $timezone::package_ensure,
  $package_name            = $timezone::package_name,
  $package_provider        = $timezone::package_provider,
  $package_install_options = $timezone::package_install_options,
  $manage_package          = $timezone::manage_package,
  $timezone                = $timezone::timezone,
) {

  case $package_ensure {
    /(latest)/: {
      $package_tzdata_ensure = 'latest'
    }
    /(present)/: {
      $package_tzdata_ensure = 'present'
    }
    /(absent)/: {
      $package_tzdata_ensure = 'present'
    }
    default: {
      fail('`package_ensure` parameter must be latest, present or absent')
    }
  }

  if $package_install_options != [] {
    validate_array($package_install_options)
  }

  if $manage_package {
    if $package_tzdata_ensure == 'present' and $::osfamily == 'Debian' {
      $_area = split($timezone, '/')
      $area = $_area[0]
      $_zone = split($timezone, '/')
      $zone = $_zone[1]
      debconf { 'update_debconf area':
        item  => 'tzdata/Areas',
        type  => 'select',
        value => $area,
      }
      debconf { 'update_debconf zone':
        item  => "tzdata/Zones/${area}",
        type  => 'select',
        value => $zone,
      }
    }

    package { $package_name:
      ensure          => $package_tzdata_ensure,
      provider        => $package_provider,
      install_options => $package_install_options,
    }
  }
}
