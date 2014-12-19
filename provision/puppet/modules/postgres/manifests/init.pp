class postgres {
  $packages = ['postgresql', 'postgis']

  package { $packages:
    ensure => installed,
  }

}