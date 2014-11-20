# == Profile profile::redis
#
# This profile is wrapper for module fsalum-redis. It install and configure
# Redis server on a node.
#
# The pfofile depends on fsalum-redis module.
#
# === Parameters
#
# [*redis_address*]
#   On which address Redis will accept connections
#
# [*redis_port*]
#   Which port Redis will be listen
#
# === Links
#
# * {fsalum/redis}[https://forge.puppetlabs.com/fsalum/redis]
#
# === Authors
#
# * Evgeniy Evtushenko <mailto:evgeniye@crytek.com>
#
class profile::redis {
  ## Hiera lookups
  $redis_address  = hiera('profile::redis::redis_address')
  $redis_port	  = hiera('profile::redis::redis_port')

  # Install Redis instance
  class { '::redis':
    conf_bind => $redis_address,
    conf_port => $redis_port,
  }
}
