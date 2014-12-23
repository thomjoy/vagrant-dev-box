stage { 'pre':
  before => Stage['main'],
}

stage { 'post': }
Stage['main'] -> Stage['post']

class { 'apt':
  always_apt_update => true,
}

exec { 'apt-get-update':
  command     => '/usr/bin/apt-get update -y',
  refreshonly => true,
}

$packages = ['build-essential', 'curl', 'language-pack-en', 'zsh', 'postgis']

package { $packages:
  ensure => installed,
}

# Forcibly activate the en_US.UTF-8 locale. Needed to have
# UTF8 encoding in PostgreSQL databases.
file { '/etc/default/locale':
  ensure  => 'file',
  owner   => 'root',
  group   => 'root',
  content => "LANG=en_US.UTF-8\n",
} ->
# Install PostgreSQL 9.4 server from the PGDG repository
class { 'postgresql::globals':
  version             => '9.4',
  manage_package_repo => true,
  encoding            => 'UTF8',
  locale              => 'en_US.utf8',
  # TODO: remove the next line after PostgreSQL 9.4 release
  postgis_version     => '2.1',
} ->
class { 'postgresql::server':
  listen_addresses           => '*',
  ip_mask_deny_postgres_user => '0.0.0.0/32',
  ip_mask_allow_all_users    => '0.0.0.0/0',
  postgres_password          => 'funkytown',
} ->
postgresql::server::role { 'vagrant':
  createdb      => true,
  login         => true,
  password_hash => postgresql_password("vagrant", "vagrant"),
}

# Install contrib modules
class { 'postgresql::server::contrib':
  package_ensure => 'present',
}

# install postgis
class { 'postgresql::server::postgis':
  package_ensure => 'present',
  require => Package['postgis']
}

# create extension
exec { "/usr/bin/psql -d template1 -c 'CREATE EXTENSION cube;'":
  user   => "postgres",
  unless => "/usr/bin/psql -d template1 -c '\\dx' | grep cube",
}

## nginx
nginx::resource::vhost { 'app.local':
  #www_root => '/var/www/app',
  proxy         => 'http://127.0.0.1:3002',
  server_name   => ['app.local'],
}

# files
user { 'vagrant':
  ensure => 'present',
}

file { '/var/www/':
  ensure => 'directory',
}

file { '/home/vagrant/.zshrc':
  ensure  => 'present',
  owner   => 'vagrant',
  group   => 'vagrant',
}

file { '/usr/bin/node':
  ensure  => 'link',
  target  => '/usr/bin/nodejs',
}

exec {
  'set shell':
    command => "/usr/bin/chsh -s /bin/zsh vagrant",
    require => Package['zsh'],
    ;
}

# proper modules
include git
include nodejs
include nginx