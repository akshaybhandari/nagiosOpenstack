class nagiosopenstack::setup::nagioshost (
  $host_list = undef,
  $address_list = undef,
) {
  if $host_list {
    $host_list.each |$index, $host_name| {
      nagios_host { $host_name:
        ensure => present,
        host_name => $host_list[$index],
        address => $address_list[$index],
        use => generic-host,
        require => Package['nagios'],
        notify => Service['nagios'],
      }
    }
  }
}
