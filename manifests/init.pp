class fcb_tomcat {

  include fcb_java

  case $facts['os']['name'] {
    'RedHat', 'CentOS':  { class{ 'fcb_tomcat::linux':   require => Class[ 'fcb_java' ], } }
    'Windows':           { class{ 'fcb_tomcat::windows': require => Class[ 'fcb_java' ], }  }
  }
}
