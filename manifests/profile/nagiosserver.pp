class nagiosopenstack::profile::nagiosserver {
  package { 'nagios3':
    ensure => latest,
  }
  package { 'nagios-nrpe-plugin':
    ensure => latest,
  }
}
