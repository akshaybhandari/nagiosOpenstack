class nagiosopenstack::role::nagiosserver inherits ::nagiosopenstack::role {
  class { 'nagiosopenstack::profile::nagiosserver': }
}
