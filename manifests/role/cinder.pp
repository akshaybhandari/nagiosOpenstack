class nagiosopenstack::role::cinder inherits ::nagiosopenstack::role {
  class { 'nagiosopenstack::profile::nrpeserver': } ->
  class { 'nagioscinder':
    service_list => $::nagiosopenstack::config::openstack_cinder_service_list,
  }
}
