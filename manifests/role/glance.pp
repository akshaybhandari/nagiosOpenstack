class nagiosopenstack::role::glance inherits ::nagiosopenstack::role {
  class { 'nagiosopenstack::profile::nrpeserver': } ->
  class { 'nagiosglance': }
}
