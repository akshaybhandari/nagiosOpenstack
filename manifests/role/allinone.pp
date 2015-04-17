class nagiosopenstack::role::allinone inherits ::nagiosopenstack::role {
  class { 'nagiosopenstack::profile::nrpeserver': }
}
