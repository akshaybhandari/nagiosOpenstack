class nagiosopenstack::profile::nagiosserver::debian {
  package { [ 'nagios3', 'nagios-plugins', 'nagios-nrpe-plugin' ]:
    ensure  => installed,
  }

  # Manage the Nagios monitoring service
  service { 'nagios3':
    ensure    => running,
    hasstatus => true,
    enable    => true,
    subscribe => [ Package['nagios3'], Package['nagios-plugins'] ],
  }
  # collect resources and populate /etc/nagios/nagios_*.cfg
  Nagios_host <||> {
    target => "${nagiosopenstack::profile::nagiosserver::cfgdir}/conf.d/nagios_host.cfg",
    require => Package['nagios3'],
    notify => Service['nagios3'],
    mode   => '0644',
  }

  Nagios_service <||> {
    target => "${nagiosopenstack::profile::nagiosserver::cfgdir}/conf.d/nagios_service.cfg",
    require => Package['nagios3'],
    notify => Service['nagios3'],
    mode => '0644',
  }
}
