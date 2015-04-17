class nagiosopenstack::role::neutron inherits ::nagiosopenstack::role {
  class { 'nagiosopenstack::profile::nrpeserver': } ->
  class { 'nagiosneutron': }
}
