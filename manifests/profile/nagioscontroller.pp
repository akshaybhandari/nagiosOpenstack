class nagiosopenstack::profile::nagioscontroller {
  package { 'nagios-nrpe-server':
    ensure => latest,
  }
  file { '/etc/sudoers.d/nagios_sudoers':
    ensure => present,
    source => 'puppet:///modules/files/nagios_sudoers',
    owner  => 'root',
    group  => 'root',
    mode   => '0440',
  }
}
