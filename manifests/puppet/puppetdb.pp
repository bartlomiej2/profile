# == Profile profile::puppet::puppetdb
#
# This profile is wrapper for puppetlabs-puppetdb module. It contains common
# PuppetDB settings. This profile should be inherited by other profile to override
# settings.
#
# The pfofile depends on puppetlabs-puppetdb module.

#
# === Parameters
#
# [*listen_address*]
#   The address that the web server should bind to for HTTP requests
#   '0.0.0.0' = all
#
# === Links
#
# * {puppetlabs/puppetdb}[https://forge.puppetlabs.com/puppetlabs/puppetdb]
#
# === Authors
#
# * Evgeniy Evtushenko <mailto:evgeniye@crytek.com>
#
class profile::puppet::puppetdb {
  ## Hiera lookups
  $listen_address	= hiera('profile::puppet::puppetdb::listen_address')
  $ssl_listen_address	= hiera('profile::puppet::puppetdb::ssl_listen_address')
  $database_host    	= hiera('profile::puppet::puppetdb::database_host')
  $database_name	= hiera('profile::puppet::puppetdb::database_name')
  $database_user    	= hiera('profile::puppet::puppetdb::database_user')
  $database_password    = hiera('profile::puppet::puppetdb::database_password')

  $puppetdb_server  	= $::fqdn

  # Configure PostgreSQL server
  include profile::postgresql::globals
  include profile::postgresql::server
  ::postgresql::server::db { 'PuppetDB_database':
    dbname    => $database_name,
    user      => $database_user,
    password  => postgresql_password($database_user, $database_password),
  }

  # Configure PuppetDB server
  class { '::puppetdb::server':
    database_host	=> $database_host,
    listen_address	=> $listen_address,
    ssl_listen_address	=> $ssl_listen_address,
    database_name	=> $database_name,
    database_username 	=> $database_user,
    database_password 	=> $database_password,
  }

  # Configure puppet master
  class { '::puppetdb::master::config':
    puppetdb_server => $puppetdb_server,
  }
}
