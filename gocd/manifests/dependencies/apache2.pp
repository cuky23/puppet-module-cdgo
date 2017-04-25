class gocd::dependencies::apache2 {
  package { 'apache2' :
    ensure => 'installed'
  }

  package { 'apache2-utils' :
    ensure => 'installed'
  }

  service { 'apache2':
    ensure => running,
    require => Package['apache2']
  }
}
