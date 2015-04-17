class nagiosopenstack::role::controller inherits ::nagiosopenstack::role {
  class { 'nagiosopenstack::profile::nrpeserver': }
  class { 'nagioscontroller': }
}
