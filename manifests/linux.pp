class fcb_tomcat::linux {

  tomcat::install { '/opt/tomcat9':
    source_url => 'https://www.apache.org/dist/tomcat/tomcat-9/v9.0.30/bin/apache-tomcat-9.0.30.tar.gz',
  }
}
