class gocd::dependencies::java (
  $jre = "openjdk-8-jre",
  $java_home = "/usr/lib/jvm/java-8-openjdk-amd64/jre" 
){
  package { "${jre}" :
    ensure => 'installed'
  }
}
