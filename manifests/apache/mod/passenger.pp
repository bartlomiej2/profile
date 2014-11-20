# == Profile profile::apache::mod:passenger
#
# This profile is wrapper for puppetlabs-apache module. It contains common
# Apache Passenger settings. This profile should be inherited by other profile to
# override settings.
#
# The pfofile depends on puppetlabs-apache module.
#
# === Parameters
#
# [*passenger_high_performance*]
#   Boolean: On, Off.
#
# === Links
#
# * {"PassengerEnabled off" not working}[http://www.conandalton.net/2010/06/passengerenabled-off-not-working.html]
# === Authors
#
# * Evgeniy Evtushenko <mailto:evgeniye@crytek.com>
#

class profile::apache::mod::passenger {
  $passenger_high_performance = hiera('profile::apache::mod::passenger::passenger_high_performance')

  class { '::apache::mod::passenger':
    passenger_high_performance  => $passenger_high_performance,
    passenger_pool_idle_time    => 600,
    passenger_max_requests      => 1000,
    passenger_root              => $::apache::params::passenger_root,
    passenger_ruby              => $::apache::params::passenger_ruby,
    passenger_max_pool_size     => 12,
  }

}

