class nagiosopenstack::setup::nagiosservice (
  $command_list = undef,
) {
  nagios_command { $command_list:
    ensure => present
  }
}
