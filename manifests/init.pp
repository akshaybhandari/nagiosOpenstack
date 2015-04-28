# == Class: nagiosopenstack
#
# Full description of class nagiosopenstack here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'nagiosopenstack':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class nagiosopenstack (
  $use_hiera = true,
  $nagios_server = undef,
  $nagios_user = undef,
  $nagios_password = undef,
  $openstack_router_list = [],
  $openstack_network_list = [],
  $openstack_tenant_list = [],
  $openstack_controller_service_list = [],
  $openstack_compute_service_list = [],
  $openstack_neutron_service_list = [],
  $openstack_cinder_service_list = [],
  $openstack_glance_service_list = [],
  $openstack_auth_url = undef,
  $openstack_neutron_url = undef,
  $openstack_nova_url = undef,
  $openstack_glance_url = undef,
  $openstack_cinder_url = undef,
  $openstack_username = undef,
  $openstack_password = undef,
  $openstack_tenant = undef,
  $openstack_openvswitch_external_bridge = undef,
) {
  if $use_hiera {
    class { '::nagiosopenstack::config':
      nagios_server                         => hiera(nagiosopenstack::nagios_server),
      nagios_user                           => hiera(nagiosopenstack::nagios_user),
      nagios_password                       => hiera(nagiosopenstack::nagios_password),
      openstack_router_list                 => hiera(nagiosopenstack::openstack::router_list),
      openstack_network_list                => hiera(nagiosopenstack::openstack::network_list),
      openstack_tenant_list                 => hiera(nagiosopenstack::openstack::tenant_list),
      openstack_controller_service_list     => hiera(nagiosopenstack::openstack::controller::service_list),
      openstack_compute_service_list        => hiera(nagiosopenstack::openstack::compute::service_list),
      openstack_neutron_service_list        => hiera(nagiosopenstack::openstack::neutron::service_list),
      openstack_cinder_service_list         => hiera(nagiosopenstack::openstack::cinder::service_list),
      openstack_glance_service_list         => hiera(nagiosopenstack::openstack::glance::service_list),
      openstack_auth_url                    => hiera(nagiosopenstack::openstack::auth_url),
      openstack_neutron_url                 => hiera(nagiosopenstack::openstack::neutron_url),
      openstack_nova_url                    => hiera(nagiosopenstack::openstack::nova_url),
      openstack_glance_url                  => hiera(nagiosopenstack::openstack::glance_url),
      openstack_cinder_url                  => hiera(nagiosopenstack::openstack::cinder_url),
      openstack_username                    => hiera(nagiosopenstack::openstack::username),
      openstack_password                    => hiera(nagiosopenstack::openstack::password),
      openstack_tenant                      => hiera(nagiosopenstack::openstack::tenant),
      openstack_openvswitch_external_bridge => hiera(nagiosopenstack::openstack::openvswitch::external_bridge),
    }
  } else {
    class { '::nagiosopenstack::config':
      nagios_server                         => $nagios_server,
      nagios_user                           => $nagios_user,
      nagios_password                       => $nagios_password,
      openstack_router_list                 => $openstack_router_list,
      openstack_network_list                => $openstack_network_list,
      openstack_tenant_list                 => $openstack_tenant_list,
      openstack_controller_service_list     => $openstack_controller_service_list,
      openstack_compute_service_list        => $openstack_compute_service_list,
      openstack_neutron_service_list        => $openstack_neutron_service_list,
      openstack_cinder_service_list         => $openstack_cinder_service_list,
      openstack_glance_service_list         => $openstack_glance_service_list,
      openstack_auth_url                    => $openstack_auth_url,
      openstack_neutron_url                 => $openstack_neutron_url,
      openstack_nova_url                    => $openstack_nova_url,
      openstack_glance_url                  => $openstack_glance_url,
      openstack_cinder_url                  => $openstack_cinder_url,
      openstack_username                    => $openstack_username,
      openstack_password                    => $openstack_password,
      openstack_tenant                      => $openstack_tenant,
      openstack_openvswitch_external_bridge => $openstack_openvswitch_external_bridge,
    }
  }
}
