class fcb_tomcat::linux(
  $install_versions    = {},
  $instances           = {}, 
  $configs             = {},
  $defaults_connectors = {},
  $connectors          = {},
){
  $install_versions.each |$install_dir, $hash| {
    tomcat::install { $install_dir:
      * => $hash,
    }
  }

  $instances.each |$instance, $hash| {
    tomcat::instance { $instance:
      * => $hash,
    }
  }

  $configs.each |$instance, $hash| {
    $catalina_base = $instances[$instance]['catalina_base']
    tomcat::config::server { $instance:
      catalina_base => $catalina_base,
      *             => $hash,
    }
  }

  $connectors.each |$instance, $connector_hash| {
    $catalina_base = $instances[$instance]['catalina_base']
    $defaults = $defaults_connectors['defaults'] + $connector_hash
    notify{"Nick $defaults":}
    #$merged_connectors = $defaults_connectors['defaults'] + $connector_hash
    $connector_hash.each |$connector, $hash| { 
      tomcat::config::server::connector { "${instance}-${connector}":
        catalina_base => $catalina_base,
        *             => $hash,
      }
    }
  }
}
