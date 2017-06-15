# puppet-timezone

[![Build Status][build-shield]][build-status]
[![Code Coverage][coverage-shield]][coverage-status]
[![Puppet Forge][forge-shield]][forge-timezone]
[![Puppet Forge - downloads][forge-shield-dl]][forge-timezone]
[![Puppet Forge - scores][forge-shield-sc]][forge-timezone]

## Description

A Puppet module for managing timezone settings. This module allows you to
install and configure timezone settings using operating system specific
facilities with just a single parameter.

## Setup

### What timezone affects

*   Locale timezone configuration file. For all supported systems this is
    `/etc/localtime`.
*   The timezone configuration file. Depending on the operating system this can
    be:
    *   `/etc/timezone` for the **Debian/Ubuntu** operating system family,
    *   `/etc/sysconfig/clock` for **CentOS/RedHat** operating system family
        below version **7**,
*   For **Debian/Ubuntu**, **CentOS/RedHat** operating system families it will
    install the `tzdata` package.
*   `puppet-timezone` depends on
    *   [puppetlabs-stdlib][puppetlabs-stdlib],
    *   [puppet-yum][puppet-yum],
    *   [puppetlabs-apt][puppetlabs-apt],
    *   [stm-debconf][stm-debconf],

### Beginning with timezone

The simplest use case is to rely on the Coordinated Universal Timezone. This can
be done by simply including the class:

```puppet
include ::timezone
```

Most of the time though you will be provisioning in specific regions of the
world and thus may want to pass a timezone:

```puppet
class { '::timezone':
    timezone => 'Europe/Berlin',
}
```

A list of valid timezone strings is available on [Wikipedia][valid-timezones].

## Usage

In addition to configuring the timezone you can also modify and customize
related settings such as if the hardware clock is set to UTC, or inject your
own zone information or even package.

```puppet
class { '::timezone':
    timezone => 'Europe/Berlin',
    package_ensure => 'present',
    manage_package => true,
}
```

## Reference

### Class: `timezone`

```puppet
class { 'timezone':
    timezone                => 'Etc/UTC',
    hw_utc                  => true,

    package_ensure          => 'present',
    package_name            => 'tzdata',
    package_provider        => 'apt',
    package_install_options => [],
    manage_package          => true,

    zoneinfo_dir           => '/usr/share/zoneinfo',
    localtime_file         => '/etc/localtime',
    localtime_file_type    => 'file',
    timezone_file          => '/etc/timezone',
    timezone_file_template => 'timezone/debian-timezone.erb',
    timezone_file_comments => false,
    timezone_update        => false,
}
```

### Class: `timezone::params`

```puppet
class { 'timezone::params':
    timezone                => 'Etc/UTC',
    hw_utc                  => true,
    package_ensure          => 'latest',
    package_install_options => [],
    manage_package          => true,
}
```

### Class: `timezone::install`

```puppet
class { 'timezone::install':
    package_ensure          => 'present',
    package_name            => 'tzdata',
    package_provider        => 'apt',
    package_install_options => [],
    manage_package          => true,
    timezone                => 'Etc/UTC',
}
```

### Class: `timezone::config`

```puppet
class { 'timezone::config':
    timezone               => 'Europe/Berlin',
    hw_utc                 => true,
    package_ensure         => 'present',
    zoneinfo_dir           => '/usr/share/zoneinfo',
    localtime_file         => '/etc/localtime',
    localtime_file_type    => 'file',
    timezone_file          => '/etc/timezone',
    timezone_file_template => 'timezone/debian-timezone.erb',
    timezone_file_comments => false,
    timezone_update        => false,
}
```

## Limitations

See [metadata.json](metadata.json) for supported platforms

## Development

### Running tests

This project contains tests for [rspec-puppet][puppet-rspec].

Quickstart:

```bash
$ gem install bundler
$ bundle install
$ bundle exec rake lint
$ bundle exec rake validate
$ bundle exec rake rubocop
$ bundle exec rake test
```

When submitting pull requests, please make sure that module documentation,
test cases and syntax checks pass.

[puppetlabs-stdlib]: https://github.com/puppetlabs/puppetlabs-stdlib
[puppetlabs-apt]: https://github.com/puppetlabs/puppetlabs-apt
[puppet-yum]: https://github.com/voxpupuli/puppet-yum
[stm-debconf]: https://github.com/smoeding/puppet-debconf
[valid-timezones]: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
[puppet-rspec]: http://rspec-puppet.com/

[build-status]: https://travis-ci.org/kogitoapp/puppet-timezone
[build-shield]: https://travis-ci.org/kogitoapp/puppet-timezone.png?branch=master
[coverage-shield]: https://coveralls.io/repos/github/kogitoapp/puppet-timezone/badge.svg?branch=master
[coverage-status]: https://coveralls.io/github/kogitoapp/puppet-timezone
[forge-timezone]: https://forge.puppetlabs.com/kogitoapp/timezone
[forge-shield]: https://img.shields.io/puppetforge/v/kogitoapp/timezone.svg
[forge-shield-dl]: https://img.shields.io/puppetforge/dt/kogitoapp/timezone.svg
[forge-shield-sc]: https://img.shields.io/puppetforge/f/kogitoapp/timezone.svg
