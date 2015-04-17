class nagiosopenstack::role::nagioscinder inherits ::nagiosopenstack::role {
  class { 'nagiosopenstack::profile::nrpeserver': }
}
