class nagiosopenstack::role::compute inherits ::nagiosopenstack::role {
  class { 'nagiosopenstack::profile::nrpeserver': } ->
  class { 'nagioscompute': }
}
