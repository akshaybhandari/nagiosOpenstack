class nagiosopenstack::role::nagioscompute inherits ::nagiosopenstack::role {
  class { 'nagiosopenstack::profile::nrpeserver': }
}
