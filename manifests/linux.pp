class fcb_tomcat::linux(
  $install_versions,
  $instances, 
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

  $instances.each |$instance, $hash| {
    tomcat::config::server { $instance:
      * => $hash 
    }
  }

#tomcat::config::server::connector { 'tomcat9-second-http':
#  catalina_base         => '/opt/tomcat9/second',
#  port                  => '8081',
#  protocol              => 'HTTP/1.1',
#  additional_attributes => {
#    'redirectPort' => '8443'
#  },
#}
}
