class fcb_tomcat::windows::config{
  $base_path = $::fcb_tomcat::windows::base_path

  concat { "${base_path}/config/server.xml":
    ensure => present,
  }
}
