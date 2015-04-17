class nagiosopenstack::role::nagiosglance inherits ::nagiosopenstack::role {
  class { 'nagiosopenstack::profile::nrpeserver': }
}
