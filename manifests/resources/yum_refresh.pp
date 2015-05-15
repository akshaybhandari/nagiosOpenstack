class nagiosopenstack::resources::yum_refresh {
  exec { 'yum_refresh':
    command     => '/usr/bin/yum clean all',
    refreshonly => true,
  }
  Exec['yum_refresh'] -> Package<||>
}
