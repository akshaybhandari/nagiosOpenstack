class nagiosopenstack::profile::nagiosserver::centos {
  package { [ 'nagios', 'nagios-plugins' ]:
    ensure  => installed,
  }

  # Manage the Nagios monitoring service
  service { 'nagios':
    ensure    => running,
    hasstatus => true,
    enable    => true,
    subscribe => [ Package['nagios'], Package['nagios-plugins'] ],
  }
  file { 'nagios_confd':
    path => "${nagiosopenstack::profile::nagiosserver::cfgdir}/conf.d/",
    ensure => directory,
    purge => true,
    recurse => true,
    notify => Service['nagios'],
    require => Package['nagios'],
    mode => '0750', owner => root, group => root;
  }

  # collect resources and populate /etc/nagios/nagios_*.cfg
  Nagios_host <<||>> {
    target => "${nagiosopenstack::profile::nagiosserver::cfgdir}/conf.d/nagios_host.cfg",
    require => Package['nagios'],
    notify => Service['nagios3'],
  }

  Nagios_service <<||>> {
    target => "${nagiosopenstack::profile::nagiosserver::cfgdir}/conf.d/nagios_service.cfg",
    require => Package['nagios'],
    notify => Service['nagios3'],
  }
}
