class nagiosopenstack::profile::nagiosserver::redhat {
  include nagiosopenstack::resources::firewall
  package { 'nagios':
    ensure  => present,
    name    => "${nagiosopenstack::profile::nagiosserver::nagios_name}",
    require => Package['httpd', 'php'],
  }
  package { 'nagios-plugin-nrpe':
    ensure => present,
    name   => 'nagios-plugins-nrpe',
  }
  package { ['httpd', 'php', 'gcc', 'glibc', 'glibc-common', 'gd', 'gd-devel']:
    ensure => present,
  }

  # Manage the Nagios monitoring service
  service { 'apache':
    ensure    => running,
    name      => 'httpd',
    hasstatus => true,
    enable    => true,
    subscribe => [ Package['httpd'] ],
  }
  service { 'nagios':
    ensure    => running,
    name      => "${::nagiosopenstack::profile::nagiosserver::nagios_name}",
    hasstatus => true,
    enable    => true,
    subscribe => [ Package['nagios'], Package['nagios-plugins'] ],
  }
  file { 'index.html':
    ensure  => present,
    path    => '/var/www/html/index.html',
    require => Package['httpd'],
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
  file { 'htpasswd.users':
    ensure  => present,
    path    => "${nagiosopenstack::profile::nagiosserver::cfgdir}/passwd",
    source  => 'puppet:///modules/nagiosopenstack/htpasswd.users',
    require => Package['nagios'],
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
  exec { 'nagios_password':
    command => "/usr/bin/htpasswd -bc /etc/nagios/passwd ${nagiosopenstack::config::nagios_user} ${nagiosopenstack::config::nagios_password}",
    user    => 'root',
    group   => 'root',
    require => File['htpasswd.users'],
  }

  # collect resources and populate /etc/nagios/nagios_*.cfg
  file { 'nagios_hosts':
    ensure  => present,
    path    => "${nagiosopenstack::profile::nagiosserver::cfgdir}/conf.d/nagios_host.cfg",
    require => Package['nagios'],
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
  file { 'nagios_services':
    ensure  => present,
    path    => "${nagiosopenstack::profile::nagiosserver::cfgdir}/conf.d/nagios_service.cfg",
    require => Package['nagios'],
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
  file { 'nagios_commands':
    ensure  => present,
    path    => "${nagiosopenstack::profile::nagiosserver::cfgdir}/conf.d/nagios_command.cfg",
    require => Package['nagios'],
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  Nagios_host <<||>>
  Nagios_service <<||>>
  Nagios_command <<||>>
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
  Nagios_command <||> {
    target  => "${nagiosopenstack::profile::nagiosserver::cfgdir}/conf.d/nagios_command.cfg",
    require => Package['nagios'],
    notify  => Service['nagios'],
    mode    => '0644',
  }

  nagios_command { 'check_nrpe_1arg':
    command_line => '/usr/lib64/nagios/plugins/check_nrpe -H $HOSTADDRESS$ -c $ARG1$',
    require      => Package['nagios-plugins-nrpe'],
  }
}
