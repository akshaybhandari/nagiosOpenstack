class nagiosopenstack::role::compute inherits ::nagiosopenstack::role {
  class { 'nagiosopenstack::profile::nrpeserver': }
  class { 'nagiosbase': } ->
  class { 'nagioscompute':
    service_list => $::nagiosopenstack::config::openstack_compute_service_list,
  }
}
