## (2017-03-23) Release 1.1.5

### Bug fixes

*   Removed unsupported "pe" version requirement.

## (2017-03-23) Release 1.1.4

### Bug fixes

*   Fixed deprecation warning about `data_provider`.

## (2017-02-15) Release 1.1.3

### Bug fixes

*   Fixed Rubocop offenses. Sorry, we offended you!
    -   use `YAML.safe_load` instead of `YAML.load`
    -   use `Security/Eval` instead of `Lint/Eval` check
*   Fixed specs to avoid nested groups.
*   Added note about using `rubocop` to README.

## (2017-02-15) Release 1.1.2

### Bug fixes

*   Fixed Rubocop configuration
*   Fixed wrong version in module metadata

## (2017-02-15) Release 1.1.1

### Maintenance

*   Updated dependecy to puppet-yum 1.0.0

## (2016-12-28) Release 1.1.0

### New features

*   Integrate [stm-debconf](https://github.com/smoeding/puppet-debconf) for
    Debian operating system family.
    This fixes [#1](https://github.com/kogitoapp/puppet-timezone/issues/1).
*   Use file or link resources for `localtime` as expected on target `osfamily`.
    This fixes [#2](https://github.com/kogitoapp/puppet-timezone/issues/2).

## (2016-12-28) Release 1.0.5

### Maintenance

*   Removed DEBUG mode for Beaker builds.
*   Removed Ruby 2.4.0 build from Travis.
*   Added required Puppet Open Source and Puppet Enterprise versions. Rule of
    thumb: if it supports Puppet 4.0 language features, it has to run.

## 2016-12-27 Release 1.0.4

### Bug fixes

*   Enable code coverage reports to [Coveralls](https://coveralls.io/github/kogitoapp/puppet-timezone).

## 2016-12-27 Release 1.0.3

### Bug fixes

*   Ignore `vendor` directory to reduce size of releases submitted to Puppet
    Forge.

## 2016-12-27 Release 1.0.2

### Bug fixes

*   Correct Puppet Forge metadata

## 2016-12-27 Release 1.0.1

### Maintenance

*   Test release for TravisCI builds.

## 2016-12-26 Release 1.0.0

Initial release of timezone management module! Hurra!

### New features

*   support package and configuration of timezone on Debian, Ubuntu, CentOS,
    RHEL, and Fedora

### Bug fixes

*   ... nothing yet!

### Maintenance

*   ... adding in Travis CI build settings and Puppet Forge deployment.
