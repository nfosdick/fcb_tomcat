class fcb_tomcat::windows(
  $destination_path,
  $install_dir,
  $version,
  $service_name,
  $ssl_config,
  $architecture     = $facts['architecture'],
  $zip_file         = "apache-tomcat-${version}-windows-${architecture}.zip",
  $download_uri     = "http://www-eu.apache.org/dist/tomcat/tomcat-9/v${version}/bin",
){
  $base_path = "${install_dir}/apache-tomcat-${version}"

  include fcb_tomcat::windows::install

  class{ 'fcb_tomcat::windows::config':
    require => Class[ 'fcb_tomcat::windows::install' ]
  }

  class{ 'fcb_tomcat::windows::service':
    require => Class[ 'fcb_tomcat::windows::config' ]
  }
}
