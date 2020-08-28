class fcb_tomcat::windows::config{
  $ssl_config = $fcb_tomcat::windows::ssl_config
  $base_path  = $fcb_tomcat::windows::base_path

  notify{"Nick $ssl_config":}

  concat { "${base_path}/conf/server.xml":
    ensure => present,
  }

  concat::fragment { 'Start server.xml':
    target  => "${base_path}/conf/server.xml",
    content => template("${module_name}/begin_server_xml.erb"),
    order   => '01',
  }

  concat::fragment { 'TLS server.xml':
    target  => "${base_path}/conf/server.xml",
    content => template("${module_name}/ssl_server_xml.erb"),
    order   => '50',
  }

  concat::fragment { 'End server.xml':
    target  => "${base_path}/conf/server.xml",
    content => template("${module_name}/end_server_xml.erb"),
    order   => '99',
  }
}
