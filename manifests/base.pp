stage { 'first':
    before => Stage['second']
}

class { "apt-get::update":
    stage  => first,
}

class { 'tools':
    stage => second,
}

include apt-get::update