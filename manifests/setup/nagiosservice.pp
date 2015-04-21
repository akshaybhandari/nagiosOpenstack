class nagiosopenstack::setup::nagiosservice (
  $host_list = undef,
) {
  if $host_list {
    $host_list.each |$index, $host_name| {
      nagios_service { $host_name:
        ensure => present,
        require => [ Package['nagios'], Nagios_host['nagios_host'] ],
        service_description => "${host_name}_Users",
        check_command => 'check_nrpe_1arg!check_users',
        host_name => $host_name,
        use => generic-service,
      }
    }
  }
}
