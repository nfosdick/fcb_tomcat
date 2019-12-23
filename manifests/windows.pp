class fcb_tomcat::windows(
  $destination_path = 'c:/larktemp',
  $version          = '9.0.30',
  $architecture     = $facts['architecture'],
  $zip_file         = "apache-tomcat-${version}-windows-${architecture}.zip",
  $download_uri     = "http://www-eu.apache.org/dist/tomcat/tomcat-9/v${version}/bin",
  $download_url     = "${download_uri}/${zip_file}",
){

  dsc_xremotefile {"Download $download_url":
    dsc_destinationpath => "${destination_path}/${zip_file}",
    dsc_uri             => $download_url,
  }
}
