class nagiosopenstack::role::cinder inherits ::nagiosopenstack::role {
  class { 'nagiosopenstack::profile::nrpeserver': } ->
  class { 'nagiosbase': } ->
  class { 'nagioscinder':
    service_list => $::nagiosopenstack::config::openstack_cinder_service_list,
  }
}
