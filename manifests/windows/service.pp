class fcb_tomcat::windows::service
{
  $service_name = $fcb_tomcat::windows::service_name
  $version      = $fcb_tomcat::windows::version

  dsc_service{ "${service_name} tomcat-${version}":
    dsc_name  => "${service_name} tomcat-${version}",
    dsc_state => 'running',
    require   => Exec[ "Install tomcat-${version} Windows Service" ],
  }  
}
