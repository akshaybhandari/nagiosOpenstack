class nagiosopenstack::role::neutron inherits ::nagiosopenstack::role {
  class { 'nagiosopenstack::profile::nrpeserver': } ->
  class { 'nagiosneutron':
    service_list => $::nagiosopenstack::config::openstack_neutron_service_list,
    ovs_bridge   => $::nagiosopenstack::config::openstack_openvswitch_external_bridge,
  }
}
