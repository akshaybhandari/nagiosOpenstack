class nagiosopenstack::resources::repo {
  if $::osfamily == 'RedHat' {
    include nagiosopenstack::resources::yum_refresh

    include ::epel
    include ::remi
  }
}
