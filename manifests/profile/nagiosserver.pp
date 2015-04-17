class nagiosopenstack::profile::nagiosserver {
  case $::osfamily {
    debian: {
    $nagios_package = 'nagios3'
    $nagios_service = 'nagios3'
    }
    redhat: {
    $nagios_package = 'nagios'
    $nagios_service = 'nagios'
    }
    default: {
      fail("This module does not support osfamily: ${::osfamily}")
    }
  }
  package { 'nagios':
    ensure => latest,
    name   => $nagios_package,
  }
  package { 'nagios-nrpe-plugin':
    ensure => latest,
  }
  exec { "/usr/bin/htpasswd -nb ${::nagiosopenstack::config::nagios_username} ${::nagiosopenstack::config::nagios_password}":
    require => Package['nagios'],
    notify  => Service['nagios'],
  }
  service { 'nagios':
    ensure     => running,
    name       => $nagios_service,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['nagios'],
  }
}
