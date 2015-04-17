class nagiosopenstack::role::cinder inherits ::nagiosopenstack::role {
  class { 'nagiosopenstack::profile::nrpeserver': } ->
  class { 'nagioscinder': }
}
