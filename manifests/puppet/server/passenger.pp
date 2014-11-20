# == Profile profile::puppet::server::passenger
#
# This profile allows to switch Puppet server from WEBrick webserver to Apache with mod_passenger.
#
# === Parameters
#
# [*puppetmaster_dir*]
#   Path where Puppet rack application will be stored.
#
# === Links
#
# * {profile::puppet::server::passenger}[https://crywiki/display/OO/profile%3A%3Apuppet%3A%3Aserver%3A%3Apassenger]
#
# === Authors
#
# * Evgeniy Evtushenko <mailto:evgeniye@crytek.com>
#

class profile::puppet::server::passenger {

  ## Hiera lookups
  $puppetmaster_dir = hiera('profile::puppet::server::passenger::puppetmaster_dir')


  include profile::apache
  include ::apache::mod::headers
  include profile::apache::mod::ssl
  include profile::apache::mod::passenger  


  # Create Puppetmaster's document root
  file { 'puppetmasterd':
    ensure  => directory,
    path    => $puppetmaster_dir,
    owner   => 'puppet',
    group   => 'apache',
    mode    => '0770',
  } ->

  # Create public directory
  file { 'puppetmasterd public':
    ensure  => directory,
    path    => "${puppetmaster_dir}/public",
    owner   => 'puppet',
    group   => 'apache',
    mode    => '0770',
  } ->

  # Create tmp directory
  file { 'puppetmasterd_tmp':
    ensure  => directory,
    path    => "${puppetmaster_dir}/tmp",
    owner   => 'puppet',
    group   => 'apache',
    mode    => '0770',
  } ->

  # Copy puppet master Rack application
  file { 'puppet_app_config':
    ensure  => 'present',
    path    => "${puppetmaster_dir}/config.ru",
    source  => '/usr/share/puppet/ext/rack/config.ru',
    owner   => 'puppet',
    group   => 'apache',
    mode    => '0770',
  } ->

  # Stop puppetmaster service to release the socket (8140 port)
  service { 'puppetmaster':
    ensure  => 'stopped',
    enable  => false,
  } ->


  # Create apache vhost for puppetmaster
  apache::vhost { 'puppetmaster':
    servername      => $::fqdn,
    port            => '8140',
    docroot         => "${puppetmaster_dir}/public",
    manage_docroot  => false,
    ssl             => true,
    ssl_cert        => "/var/lib/puppet/ssl/certs/${::fqdn}.pem",
    ssl_key         => "/var/lib/puppet/ssl/private_keys/${::fqdn}.pem",
    ssl_chain       => '/var/lib/puppet/ssl/ca/ca_crt.pem',
    ssl_ca          => '/var/lib/puppet/ssl/ca/ca_crt.pem',
    ssl_crl         => '/var/lib/puppet/ssl/ca/ca_crl.pem',
    ssl_certs_dir   => '/var/lib/puppet/ssl/ca',
    error_log_file  => 'puppetmaster_passenger-error.log',
    access_log_file => 'puppetmaster_passenger-access.log',
    request_headers => [
      'set X-SSL-Subject %{SSL_CLIENT_S_DN}e',
      'set X-Client-DN %{SSL_CLIENT_S_DN}e',
      'set X-Client-Verify %{SSL_CLIENT_VERIFY}e',],
    directories => [
      {  path            => $puppetmaster_dir,
         options         => ['None'],
         allow           => 'from All',
         allow_override  => ['None'],
         order           => 'Allow,Deny',
      },
    ],
    custom_fragment => '
      SSLOptions              +StdEnvVars +ExportCertData
      SSLProtocol             All -SSLv2
      SSLCipherSuite          HIGH:!ADH:RC4+RSA:-MEDIUM:-LOW:-EXP
      SSLVerifyClient         optional
      SSLVerifyDepth          1',
  }

}
