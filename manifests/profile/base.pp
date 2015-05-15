class nagiosopenstack::profile::base {
  # Load all the parameters
  include ::nagiosopenstack

  # Update apt sources list
  case $::osfamily {
    'redhat': {
      include nagiosopenstack::resources::yum_refresh
      include nagiosopenstack::resources::repo
      Exec['yum_refresh'] -> Package<||>
      $plugins_name = 'nagios-plugins-all'
    }
    'debian': {
      include ::apt::update
      Exec['apt_update'] -> Package<||>
      $plugins_name = 'nagios-plugins'
    }
    default: { fail("No such osfamily: ${::osfamily} yet defined") }
  }
  package { 'nagios-plugins':
    ensure => present,
    name   => $plugins_name,
  }
}
