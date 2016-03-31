class nginx {
  $wwwdir = "/var/www"
  $nginxpath = "/etc/nginx"
  
  case $osfamily {
    'RedHat':   {
      $package = 'nginx',
      $fowner = 'root',
      $fgroup = 'root',
      $docroot = '/var/www',
      $confdir = '/etc/nginx',
      $srvblkdir = "${confdir}/conf.d",
      $logsdir = '/var/log/nginx',
      $srvname = 'nginx',
      $srvuser = 'nginx',
    }
    'Debian':   {
      $package = 'nginx',
      $fowner = 'root',
      $fgroup = 'root',
      $docroot = '/var/www',
      $confdir = '/etc/nginx',
      $srvblkdir = "${confdir}/conf.d",
      $logsdir = '/var/log/nginx',
      $srvname = 'nginx',
      $srvuser = 'www-data',
    }
    'Windows':  {
      $package = 'nginx-service',
      $fowner = 'Administrator',
      $fgroup = 'Administrator',
      $confdir = 'C:/ProgramData/nginx',
      $docroot = '${confdir}/html',
      $srvblkdir = "${confdir}/conf.d",
      $logsdir = '${confdir}/logs',
      $srvname = 'nginx',
      $srvuser = 'nobody',
    }
    default:    { fail("OS Family ${osfamily} is not supported) }
    }
  }
  
  File {
    owner =>  "${fowner}",
    group =>  "${fgroup}",
    mode  =>  '0644',
  }

  package { "$package":
    ensure  =>  present,
  }

  file { "${confdir}/nginx.conf":
    ensure  => file,
    content =>  template('templates/nginx.conf.erb'),
    require => Package["${package}"],
    notify  =>  Service["${srvname}"],
  }
  
  file { "${srvblkdir}/defalt.conf":
    ensure  => file,
    content =>  template('templates/default.conf.erb'),
    require => Package["${package}"],
    notify  =>  Service["${srvname}"],
  }
  
  service { "$srvname":
    ensure  =>  running,
  }
  
  file { "${docroot}":
    ensure  => directory,
  }

  file { "${docroot}/index.html":
    ensure  => file,
    source  => 'puppet:///modules/nginx/index.html',
    require =>  File["${docroot}"],
  }

}
