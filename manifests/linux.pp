class fcb_tomcat::linux(
  $install_versions = {},
  $instances        = {}, 
  $configs          = {},
  $connectors       = {},
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

  connectors.each |$instance, $hash| {
    $catalina_base = $instances[$instance]['catalina_base']
    tomcat::config::server::connector { 'tomcat9-second-http':
      catalina_base => $catalina_base,
      *             => $hash,
    }
  }
}
