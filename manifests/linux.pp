class fcb_tomcat::linux(
  $install_versions,
  #https://archive.apache.org/dist/tomcat/tomcat-8/v${tomcat_8_5_version}/bin/apache-tomcat-${tomcat_8_5_version}.tar.gz"
){
  $install_versions.each |$install_dir, $hash| {
    tomcat::install { $install_dir:
      * => $hash,
    }
  }

  $install_versions.each |$instance, $hash| {
    tomcat::instance { $instance:
      * => $hash,
    }
  }
}
