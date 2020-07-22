# fcb_tomcat

#### Table of Contents

1. [Overview](#overview)
1. [Module Description](#module-description)
1. [Setup](#setup)
1. [Usage](#usage)
   - [Manifest](#Manifest)
   - [Apply](#Apply)
1. [Hiera](#hiera)
   - [Linux](#Linux)
   - [Windows](#Windows)
   - [Merge](#Merge)

## Overview

This module installs tomcat on Windows or Linux platforms.  The init.pp makes use of OS.Name fact to simplify implementation and determine the proper way to install Java.  The primary purpose of this wrapper module is abstract the complexity of installing tomcat on windows or linux.  The secondary purpose is to avoid making any manual updates to the linux forge module.  This helps ensure long term supportability and upgrade ability of the forge module.  

## Module Description

There are 2 core yaml files used to configure Tomcat.
* defaults.yaml 
* merge.yaml

### Linux Install
The linux install uses the standard forge puppet module to install Tomcat:
```
https://forge.puppet.com/puppetlabs/tomcat
```

### Windows
The Windows installation makes use of custom install manifests as there was not an existing forge module for install Tomcat on Windows.

## Setup
These fcb_tomcat module prerequisites for to function properly.
```
puppet module install puppetlabs-stdlib --version 6.3.0
puppet module install puppetlabs-java --version 6.3.0
puppet module install puppetlabs-concat --version 6.2.0
puppet module install puppet-archive --version 4.5.0
puppet module install puppetlabs-dsc --version 1.9.3
```
## Usage
### Manifest
```
node default {
  include fcb_tomcat
}
```
### Apply
```
puppet apply -e 'include fcb_tomcat'
```

## Hiera
The module hierarchy (hiera.yaml) is primarily used for setting defaults.

```
  - name: "Merge Options"
    paths:
      - "merge.yaml"
  - name: "Examples"
    paths:
      - "examples.yaml"
  - name: "The Default Setup for Tomcat"
    paths:
      - "defaults.yaml"
```
### Linux
#### Base Version Install
Multiple version of tomcat can be installed on the same node with the below syntax.
```
fcb_tomcat::linux::install_versions:
  '/opt/tomcat-9':
    source_url: 'https://www.apache.org/dist/tomcat/tomcat-9/v9.0.30/bin/apache-tomcat-9.0.30.tar.gz'
  '/opt/tomcat-8-5':
    source_url: 'https://www.apache.org/dist/tomcat/tomcat-8/v8.5.50/bin/apache-tomcat-8.5.50.tar.gz'
```
#### Connector Defaults
This is how you can define the default connector configuration.  The value are deep merged with any overrides defined in hiera.  The primary purpose of default connector settings is to avoid duplicate configuration at any hiera level.  
```
fcb_tomcat::linux::defaults_connectors:
  http-connector:
    purge_connectors: false
    port: '8080'
    protocol: 'HTTP/1.1'
    additional_attributes:
      redirectPort: '8443'
  https-connector:
    purge_connectors: true
    port: '8443'
    protocol: 'HTTP/1.1'
    additional_attributes:
      sslProtocol: 'TLSv1'
```
#### Instance Creation
This is how you can define one more more instances of Tomcat in hiera.  
```
fcb_tomcat::linux::instances:
  default-instance:
    catalina_home: '/opt/tomcat-9'
    catalina_base: '/opt/tomcat-9/default-instance'
  first-instance:
    catalina_home: '/opt/tomcat-8-5'
    catalina_base: '/opt/tomcat-8-5/first-instance'
  second-instance:
    catalina_home: '/opt/tomcat-9'
    catalina_base: '/opt/tomcat-9/second-instance'
```
#### Server Config
This will set a default values for the tomcat instances.  This config was set to avoid repetitive configs, for example, a common port or catalina_base.
```
fcb_tomcat::linux::configs:
  default-instance:
    port: '8116'
```
#### Connector Defaults
This will set a default values for connectors for tomcat instances.  This config was set to avoid repetitive configs for connectors.  
```
fcb_tomcat::linux::connectors:
  default-instance:
    http-connector:
      protocol: 'HTTP/1.1'
      additional_attributes:
        redirectPort: '8443'
    https-connector:
      protocol: 'HTTP/1.1'
      additional_attributes:
        sslProtocol: 'TLS'
    ajp-connector:
      port: '8109'
      protocol: 'AJP/1.3'
      additional_attributes:
        redirectPort: '8543'
```
### Windows
```
fcb_tomcat::windows::destination_path: 'c:/larktemp'
fcb_tomcat::windows::install_dir: 'c:/tomcat'
fcb_tomcat::windows::version: '9.0.30'
fcb_tomcat::windows::service_name: 'Apache Tomcat 9.0'
```
### Merge
This yaml file is used to set the merge stategy for the hiera data for the module.  It is a deep merge strategy to allow the use of the default yaml files for common setting.
```
lookup_options:
  "fcb_tomcat::.*":
    merge:                          # Merge the values found across hierarchies, instead of getting the first one
      strategy: deep                # Do a deep merge, useful when dealing with Hashes (to override single subkeys)
      merge_hash_arrays: true
```
