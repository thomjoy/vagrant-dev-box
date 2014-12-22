stage { 'first':
  before => Stage['second']
}

stage { 'second': }

class { 'apt-get::update':
  stage  => first,
}

class { 'tools':
  stage => second,
}

user { 'vagrant':
  ensure => 'present',
}

file { '/var/www/':
  ensure => 'directory',
}

class { 'postgresql::globals':
  manage_package_repo => true,
  version             => '9.3',
}

class { 'postgresql::server':
  postgres_password => 'funkytown'
}

include apt-get::update
include tools
include nginx
include nodejs
