class nagiosopenstack::resources::firewall {
  include ::firewall
  firewall { "80 - http":
    proto  => 'tcp',
    action => 'accept',
    port   => '80',
    before => [ Class['::firewall'] ],
  }
}

