class nagiosopenstack::profile::nagiosserver {
  case $::osfamily {
    'redhat': {
      $cfgdir = '/etc/nagios'
      $nagios_name = 'nagios'
      include nagiosopenstack::profile::nagiosserver::redhat
    }
    'debian': {
      $cfgdir = '/etc/nagios3'
      $nagios_name = 'nagios3'
      include nagiosopenstack::profile::nagiosserver::debian
    }
    default: { fail("No such osfamily: ${::osfamily} yet defined") }
  }
}
