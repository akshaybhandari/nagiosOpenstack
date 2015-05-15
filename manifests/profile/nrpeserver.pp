class nagiosopenstack::profile::nrpeserver {
  case $::osfamily {
    'redhat': {
      $nrpe_name = 'nrpe'
      $nrpe_cfgdir = '/etc/nrpe.d'
      $plugins_name = 'nagios-plugins-all'
    }
    'debian': {
      $nrpe_name = 'nagios-nrpe-server'
      $nrpe_cfgdir = '/etc/nagios/nrpe.d'
      $plugins_name = 'nagios-plugins'
    }
    default: { fail("No such osfamily: ${::osfamily} yet defined") }
  }
  # install package nagios-nrpe-server
  package { 'nagios-nrpe-server':
    ensure => present,
    name   => $nrpe_name,
  }

  # add nagios users to sudoers
  file { '/etc/sudoers.d/nagios_sudoers':
    ensure => present,
    source => 'puppet:///modules/nagiosopenstack/nagios_sudoers',
    owner  => 'root',
    group  => 'root',
    mode   => '0440',
  }

  # nagios-nrpe configuration to allow nagios-server
  file { '/etc/nagios/nrpe.cfg':
    ensure  => present,
    source  => "puppet:///modules/nagiosopenstack/${::osfamily}/nrpe.cfg",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['nagios-nrpe-server'],
  }
  file_line { '/etc/nagios/nrpe.cfg':
    path    => '/etc/nagios/nrpe.cfg',
    line    => "allowed_hosts=127.0.0.1,${::nagiosopenstack::config::nagios_server}",
    match   => 'allowed_hosts=*',
    notify  => Service['nagios-nrpe-server'],
    require => File['/etc/nagios/nrpe.cfg'],
  }
  file { "nrpe_command.cfg":
    ensure  => present,
    path    => "${nrpe_cfgdir}/nrpe_command.cfg",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service['nagios-nrpe-server'],
    require => Package['nagios-nrpe-server'],
  }

  # Restart nagios-nrpe-server
  service { 'nagios-nrpe-server':
    ensure     => running,
    name       => $nrpe_name,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['nagios-nrpe-server'],
  }
}
