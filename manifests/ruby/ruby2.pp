# == Profile profile::ruby::ruby2
#
# This profile is wrapper for module puppet-ruby_version. It install ruby-2.x.
#
# The pfofile depends on puppet-ruby_version and maestrodev-rvm modules.
#
# === Parameters
#
# [*ruby_version*]
#   Which ruby version will be installed. For example, "2.1.2".
#
# === Links
#
# * {puppet-ruby_version}[https://crywiki/display/OO/puppet-ruby_version]
# * {maestrodev/rvm}[https://forge.puppetlabs.com/maestrodev/rvm]
#
# === Authors
#
# * Evgeniy Evtushenko <mailto:evgeniye@crytek.com>
#
class profile::ruby::ruby2 {
  ## Hiera lookups
  $ruby_version = hiera('profile::ruby::ruby2::ruby_version')

  # Install ruby
  class { '::ruby_version': 
    ruby_version  => $ruby_version,
  }
}
