class tools {
  $packages = ['build-essential', 'curl', 'language-pack-en']

  package { $packages:
    ensure => installed,
  }
}