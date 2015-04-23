class nagiosopenstack::profile::base {
  # Load all the parameters
  include ::nagiosopenstack

  # Update apt sources list
  include ::apt::update
}
