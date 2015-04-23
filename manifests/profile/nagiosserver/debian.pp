class nagiosopenstack::profile::nagiosserver::debian {
#  nagios_name = $::nagiosopenstack::profile::nagiosserver::nagios_name
  package { 'nagios':
    ensure => latest,
    name   => "${nagiosopenstack::profile::nagiosserver::nagios_name}",
  }
  package { [ 'nagios-plugins', 'nagios-nrpe-plugin' ]:
    ensure  => latest,
  }

  # Manage the Nagios monitoring service
  service { 'nagios':
    ensure    => running,
    name      => "${nagiosopenstack::profile::nagiosserver::nagios_name}",
    hasstatus => true,
    enable    => true,
    subscribe => [ Package['nagios'], Package['nagios-plugins'] ],
  }
  # collect resources and populate /etc/nagios/nagios_*.cfg
  Nagios_host <<||>>
  Nagios_service <<||>>

  Nagios_host <||> {
    target  => "${nagiosopenstack::profile::nagiosserver::cfgdir}/conf.d/nagios_host.cfg",
    require => Package['nagios'],
    notify  => Service['nagios'],
    mode    => '0644',
  }

  Nagios_service <||> {
    target  => "${nagiosopenstack::profile::nagiosserver::cfgdir}/conf.d/nagios_service.cfg",
    require => Package['nagios'],
    notify  => Service['nagios'],
    mode    => '0644',
  }
}
