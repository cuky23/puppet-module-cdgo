This module is based on the gitlab project for go_ci

full credit to https://github.com/michaeltchapman/puppet-gocd for inspiring this update.

more abstraction and this version is dropped into modules. 

This example will pull the debian version of gocd.  
```
call it with class {"gocd":}
```
This version is simply called gocd, Heira usage style has been changed, put this into something like local.yaml
Example 
```
gocd::active: true
gocd::server: true
gocd::agent: true
gocd::dependencies::java::jre: 'openjdk-8-jre'
gocd::dependencies::java::java_home: '/usr/lib/jvm/java-8-openjdk-amd64/jre'
gocd::params:
   version: 17.3.0
   build: 4704
   server_ip: '192.168.1.22'
   server_port: 8153

```

CUKY
