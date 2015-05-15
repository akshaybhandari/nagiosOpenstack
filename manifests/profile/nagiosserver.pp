class nagiosopenstack::profile::nagiosserver {
  case $::osfamily {
    'redhat': {
      $cfgdir = '/etc/nagios'
      $nagios_name = 'nagios'
      class {'nagiosopenstack::profile::nagiosserver::redhat':
        require => Class['nagiosopenstack::resources::repo'],
      }
    }
    'debian': {
      $cfgdir = '/etc/nagios3'
      $nagios_name = 'nagios3'
      class {'nagiosopenstack::profile::nagiosserver::debian': }
    }
    default: { fail("No such osfamily: ${::osfamily} yet defined") }
  }
}
