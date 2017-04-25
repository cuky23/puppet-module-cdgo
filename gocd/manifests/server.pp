class gocd::server(
  $go_server_package_download_path = '/var/tmp/go_server.deb',
  $dl_protocol = $::gocd::dl_protocol,
  $dl_server = $::gocd::dl_server
){
  #example wget "https://download.gocd.io/binaries/17.3.0-4704/deb/go-server_17.3.0-4704_all.deb"
  $go_config = $::gocd::params
  $version = $go_config['version']
  $build = $go_config['build']
  $go_server_deb_package = "go-server_${version}-${build}_all.deb"
  $go_server_deb_package_url = "${dl_protocol}://${dl_server}/binaries/${version}-${build}/deb/${go_server_deb_package}"
  

  Exec {
    path => "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin"
  }

  include gocd::dependencies::java, gocd::dependencies::apache2, gocd::dependencies::unzip

  exec { 'download_go_server_package':
    command => "wget ${go_server_deb_package_url} -O ${go_server_package_download_path}",
    unless => "ls -la ${go_server_package_download_path}",
    creates => $go_server_download_path,
    timeout => 0
  }

  exec { 'install_go_server':
    command => "dpkg -i ${$go_server_package_download_path}",
    user => 'root',
    require => [Exec['download_go_server_package'], Class['gocd::dependencies::unzip'], Class['gocd::dependencies::java']]
  }

  service { 'go-server':
    ensure => running,
    require => Exec['install_go_server']
  }
}
