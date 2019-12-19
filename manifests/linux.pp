class fcb_tomcat::linux(
  $install,
  #$install_dir = '/opt/tomcat-9',
  #$install_url = 'https://www.apache.org/dist/tomcat/tomcat-9/v9.0.30/bin/apache-tomcat-9.0.30.tar.gz',
  #https://archive.apache.org/dist/tomcat/tomcat-8/v${tomcat_8_5_version}/bin/apache-tomcat-${tomcat_8_5_version}.tar.gz"
){
  $install.each |$instance, $values| {
    $install_dir = $values['install_dir']
    $install_url = $values['install_url']

    tomcat::install { $install_dir:
      source_url => $install_url,
    }

    tomcat::instance { $instance:
      catalina_home => $install_dir,
      catalina_base => "${install_dir}/${instance}",
    }
  }
}
