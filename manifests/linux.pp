class fcb_tomcat::linux(
  $install_versions,
  $instances, 
  #https://archive.apache.org/dist/tomcat/tomcat-8/v${tomcat_8_5_version}/bin/apache-tomcat-${tomcat_8_5_version}.tar.gz"
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
}
