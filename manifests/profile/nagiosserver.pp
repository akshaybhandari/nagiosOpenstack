class nagiosopenstack::profile::nagiosserver {
  case $::osfamily {
    'centos': {
      $cfgdir = '/etc/nagios'
      include nagiosopenstack::profile::nagiosserver::centos
    }
    'debian': {
      $cfgdir = '/etc/nagios3'
      include nagiosopenstack::profile::nagiosserver::debian
    }
    default: { fail("No such osfamily: ${::osfamily} yet defined") }
  }
}
