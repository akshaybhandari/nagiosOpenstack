class nagiosopenstack::profile::nagiosserver {
  case $::osfamily {
    'centos': {
      $cfgdir = '/etc/nagios'
      $apache_service = 'httpd'
      include nagiosopenstack::profile::nagiosserver::centos
    }
    'debian': {
      $apache_service = 'apache2'
      $cfgdir = '/etc/nagios3'
      include nagiosopenstack::profile::nagiosserver::debian
    }
    default: { fail("No such osfamily: ${::osfamily} yet defined") }
  }
}
