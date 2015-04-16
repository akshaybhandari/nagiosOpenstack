class nagiosopenstack::role::nagiosneutron inherits ::nagiosopenstack::role {
  class { 'nagiosopenstack::profile::nagiosneutron': }
}
