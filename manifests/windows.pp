class fcb_tomcat::windows(
  $destination_path = 'c:/larktemp',
  $install_dir      = 'c:/tomcat',
  $version          = '9.0.30',
  $architecture     = $facts['architecture'],
  $zip_file         = "apache-tomcat-${version}-windows-${architecture}.zip",
  $download_uri     = "http://www-eu.apache.org/dist/tomcat/tomcat-9/v${version}/bin",
  $download_url     = "${download_uri}/${zip_file}",
  $service_name     = 'Apache Tomcat 9.0',
){
  $zip_file_path = "${destination_path}/${zip_file}"
  $service_cmd   = "${install_dir}/apache-tomcat-${version}/bin/service.bat"

  dsc_xremotefile {"Download $download_url":
    dsc_destinationpath => $zip_file_path,
    dsc_uri             => $download_url,
    before              => Dsc_archive[ "Unzip $zip_file" ],
  }

  file { $install_dir:
    ensure => directory,
    before => Dsc_archive[ "Unzip $zip_file" ],
  }

  dsc_archive {"Unzip $zip_file":
    dsc_ensure      => 'present',
    dsc_path        => $zip_file_path,
    dsc_destination => $install_dir,
  }

#  unless   => "if(Get-Command java | Select-Object Version|Select-String ${java_version}){ exit 0 }else{ exit 1 }",
  exec { "Install tomcat-${version} Windows Service":
    command   => "$service_cmd install tomcat-${version}",
    #unless    => "if(Get-Command tomcat-${version}){ exit 0 }else{ exit 1 }",
    onlyif    => "Get-Service tomcat-${version}",
    provider  => powershell,
    #logoutput => true,
    require   => Dsc_archive[ "Unzip $zip_file" ],
  }

#  dsc_service{"tomcat-${version}":
#    dsc_name  => "${service_name} tomcat-${version}",
#    dsc_state => 'running',
#    require   => Exec[ "Install tomcat-${version} Windows Service" ],
#  }  
}
