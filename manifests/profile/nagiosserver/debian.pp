class nagiosopenstack::profile::nagiosserver::debian {
#  nagios_name = $::nagiosopenstack::profile::nagiosserver::nagios_name
  package { 'nagios':
    ensure => present,
    name   => "${nagiosopenstack::profile::nagiosserver::nagios_name}",
  }
  package { [ 'nagios-plugins', 'nagios-nrpe-plugin' ]:
    ensure  => present,
  }

  # Manage the Nagios monitoring service
  service { 'nagios':
    ensure    => running,
    name      => "${nagiosopenstack::profile::nagiosserver::nagios_name}",
    hasstatus => true,
    enable    => true,
    subscribe => [ Package['nagios'], Package['nagios-plugins'] ],
  }

  file { 'htpasswd.users':
    ensure  => present,
    path    => "${nagiosopenstack::profile::nagiosserver::cfgdir}/htpasswd.users",
    source  => 'puppet:///modules/nagiosopenstack/htpasswd.users',
    require => Package['nagios'],
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  exec { 'nagios_password':
    command => "/usr/bin/htpasswd -bc /etc/nagios3/htpasswd.users ${nagiosopenstack::config::nagios_user} ${nagiosopenstack::config::nagios_password}",
    user    => 'root',
    group   => 'root',
    require => File['htpasswd.users'],
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
