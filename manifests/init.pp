class fcb_tomcat {

  include fcb_java

  case $facts['os']['name'] {
    'RedHat', 'CentOS':  { include fcb_tomcat::linux  }
    'Windows':           { include fcb_tomcat::windows  }
  }
}
