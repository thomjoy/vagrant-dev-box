class nodejs {

  exec { 'add_node_repo':
    command => '/usr/bin/curl -sL https://deb.nodesource.com/setup | sudo sh -'
  }

  $packages = ['nodejs']
  package { $packages:
    require => Exec['add_node_repo'],
  }
}