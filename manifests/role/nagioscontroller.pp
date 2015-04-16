class nagiosopenstack::role::nagioscontroller inherits ::nagiosopenstack::role {
  class { 'nagiosopenstack::profile::nagioscontroller': }
}
