class fcb_tomcat::windows::config{
  $base_path = $::fcb_tomcat::windows::base_path

  concat { "${base_path}/conf/server.xml":
    ensure => present,
  }

  concat::fragment { 'httpd.conf':
    target  => "${base_path}/conf/server.xml",
    content => template("${module_name}/begin_server_xml.erb"),
    order   => '01',
  }
}
