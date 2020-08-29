class fcb_tomcat::windows::install
{
  $destination_path = $fcb_tomcat::windows::destination_path
  $install_dir      = $fcb_tomcat::windows::install_dir
  $version          = $fcb_tomcat::windows::version
  $service_name     = $fcb_tomcat::windows::service_name
  $ssl_config       = $fcb_tomcat::windows::ssl_config
  $zip_file         = $fcb_tomcat::windows::zip_file
  $download_uri     = $fcb_tomcat::windows::download_uri
  $architecture     = $fcb_tomcat::windows::architecture
  $download_url     = "${download_uri}/${zip_file}",
  $zip_file_path    = "${destination_path}/${zip_file}"
  $base_path        = "${install_dir}/apache-tomcat-${version}"
  $service_cmd      = "${base_path}/bin/service.bat"

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

  exec { "Install tomcat-${version} Windows Service":
    command   => "$service_cmd install tomcat-${version}",
    unless    => "if(Get-Service tomcat-${version}){ exit 0 }else{ exit 1 }",
    provider  => powershell,
    logoutput => true,
    cwd       => "${base_path}/bin",
    require   => Dsc_archive[ "Unzip $zip_file" ],
  }
}
