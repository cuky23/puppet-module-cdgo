class gocd::agent(
  $go_agent_package_download_path = '/var/tmp/go_agent.deb',
  $dl_protocol = $::gocd::dl_protocol,
  $dl_server = $::gocd::dl_server  
){
  #example wget "https://download.gocd.io/binaries/17.3.0-4704/deb/go-agent_17.3.0-4704_all.deb"
  $java_home = $::gocd::dependencies::java::java_home
  $go_config = $::gocd::params
  $version = $go_config['version']
  $build = $go_config['build']
  $go_server_ip = $go_config['server_ip']
  $go_server_port = $go_config['server_port'] 
  $go_agent_deb_package = "go-agent_${version}-${build}_all.deb"
  $go_agent_deb_package_url = "${dl_protocol}://${dl_server}/binaries/${version}-${build}/deb/${go_agent_deb_package}"

  notify{"gocd::agent  $go_agent_deb_package_url $java_home $go_server_ip $go_server_port":}

  Exec {
    path => "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin"
  }

  include gocd::dependencies::java, gocd::dependencies::apache2

  exec { 'download_go_agent_package':
    command => "wget ${go_agent_deb_package_url} -O ${go_agent_package_download_path}",
    unless => "ls -la ${go_agent_package_download_path}",
    creates => $go_agent_download_path,
  }

  exec { 'install_go_agent':
    command => "dpkg -i ${$go_agent_package_download_path}",
    user => 'root',
    require => [Exec['download_go_agent_package'], Class['gocd::dependencies::java']]
  }

  file { 'agent_configuration':
    path => '/etc/default/go-agent',
    content => template('gocd/go_agent_configuration.erb'),
    require => Exec['install_go_agent'],
    notify => Service['go-agent']
  }

  service { 'go-agent':
    ensure => running,
    require => Exec['install_go_agent']
  }
}
