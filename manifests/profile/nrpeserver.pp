class nagiosopenstack::profile::nrpeserver {
  # install package nagios-nrpe-server
  package { 'nagios-nrpe-server':
    ensure => latest,
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
    source  => 'puppet:///modules/nagiosopenstack/nrpe.cfg',
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

  # Restart nagios-nrpe-server
  service { 'nagios-nrpe-server':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['nagios-nrpe-server'],
  }
}
