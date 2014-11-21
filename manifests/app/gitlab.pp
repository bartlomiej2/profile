# == Profile profile::app::gitlab
#
# This profile install GitLab istance.
#
# === Parameters
#
# [*ensure*]
#   Which ruby version will be installed. For example, "2.1.2".
#
# [*gitlab_address*]
#
#
# [*ruby_version*]
#
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
class profile::app::gitlab {
  ## Hiera Lookups
  $gitlab_ensure  = hiera('profile::app::gitlab::gitlab_ensure')
  $gitlab_group	  = hiera('profile::app::gitlab::gitlab_group')
  $gitlab_address = hiera('profile::app::gitlab::gitlab_address')
  $ruby_version	  = hiera('profile::ruby::ruby2::ruby_version')

  # Install dependencies
  include profile::apache
  include profile::apache::mod::ssl
  include profile::apache::mod::passenger
  include profile::redis
  include profile::ruby::ruby2
  include profile::postgresql::globals
  include profile::postgresql::server

  # Manage GitLab instance
  class { '::gitlab':
    ensure	    => $gitlab_ensure,
    gitlab_group    => $gitlab_group,
    gitlab_address  => $gitlab_address,
    ruby_version    => $ruby_version,
  }

  # Set class execution order
  Class['profile::redis'] -> Class['profile::ruby::ruby2'] -> Class['profile::apache'] -> Class['::gitlab']
  Class['profile::postgresql::globals'] -> Class['profile::postgresql::server'] -> Class['::gitlab']
}
