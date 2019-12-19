class fcb_tomcat::linux(
  $install,
  #$install_dir = '/opt/tomcat-9',
  #$install_url = 'https://www.apache.org/dist/tomcat/tomcat-9/v9.0.30/bin/apache-tomcat-9.0.30.tar.gz',
  #https://archive.apache.org/dist/tomcat/tomcat-8/v${tomcat_8_5_version}/bin/apache-tomcat-${tomcat_8_5_version}.tar.gz"
){
  notify{"Blah $install":}
  $install.each |$key, $values| {
    notify{"Nick $values['install_dir'] and $values['install_url]":}
    #tomcat::install { $values['install_dir']:
    #  source_url => $values['install_url],
    #}
  }
    #tomcat::install { $install_dir:
    #  source_url => $install_url,
    #}
}
