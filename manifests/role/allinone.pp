class nagiosopenstack::role::allinone inherits ::nagiosopenstack::role {
  class { 'nagiosopenstack::profile::nrpeserver': }
  class { 'nagiosbase': }
  class { 'nagioscontroller':
    router_list  => $::nagiosopenstack::config::openstack_router_list,
    service_list => $::nagiosopenstack::config::openstack_controller_service_list,
    network_list => $::nagiosopenstack::config::openstack_network_list,
    tenant_list  => $::nagiosopenstack::config::openstack_tenant_list,
    auth_url     => $::nagiosopenstack::config::openstack_auth_url,
    neutron_url  => $::nagiosopenstack::config::openstack_neutron_url,
    nova_url     => $::nagiosopenstack::config::openstack_nova_url,
    username     => $::nagiosopenstack::config::openstack_username,
    password     => $::nagiosopenstack::config::openstack_password,
    tenant       => $::nagiosopenstack::config::openstack_tenant,
  }
  class { 'nagioscompute':
    service_list => $::nagiosopenstack::config::openstack_compute_service_list,
  }
  class { 'nagioscinder':
    service_list => $::nagiosopenstack::config::openstack_cinder_service_list,
  }
  class { 'nagiosglance':
    service_list => $::nagiosopenstack::config::openstack_glance_service_list,
  }
  class { 'nagiosneutron':
    service_list => $::nagiosopenstack::config::openstack_neutron_service_list,
    ovs_bridge   => $::nagiosopenstack::config::openstack_openvswitch_external_bridge,
  }
}
