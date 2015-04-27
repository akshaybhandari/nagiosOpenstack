class nagiosopenstack::role::controller inherits ::nagiosopenstack::role {
  class { 'nagiosopenstack::profile::nrpeserver': }
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
}
