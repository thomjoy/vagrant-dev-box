class apt-get::update {
  exec { "apt-get update":
    path => "/usr/bin"
  }
}