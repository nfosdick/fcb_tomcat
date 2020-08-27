class fcb_tomcat::windows::config{
  $base_path = $::fcb_tomcat::windows::base_path

  concat { "${base_path}/conf/server.xml":
    ensure => present,
  }

  concat::fragment { 'Start server.xml':
    target  => "${base_path}/conf/server.xml",
    content => template("${module_name}/begin_server_xml.erb"),
    order   => '01',
  }

  concat::fragment { 'End server.xml':
    target  => "${base_path}/conf/server.xml",
    content => template("${module_name}/end_server_xml.erb"),
    order   => '99',
  }
}
