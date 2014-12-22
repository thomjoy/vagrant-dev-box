class postgres {
  $packages = ['postgresql', 'postgis']

  package { $packages:
    ensure => installed,
  }

  class { 'postgresql::server':
    listen => ['*', ],
    port   => 5432,
    acl   => ['host all all 0.0.0.0/0 md5', ],
  }
}