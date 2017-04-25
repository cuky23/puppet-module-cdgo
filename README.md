# puppet-module-cdgo
a module for puppet to install gocd

This module is based on the gitlab project for go_ci,  full credit to https://github.com/michaeltchapman/puppet-gocd for inspiring this update.

I have put more abstraction around getting versions of software out to heira and this version is just dropped into modules. 
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
