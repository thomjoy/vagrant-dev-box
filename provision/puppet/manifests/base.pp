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

file { '/var/www/':
  ensure => 'directory',
}

include apt-get::update
include tools
include nginx
include nodejs
include postgres