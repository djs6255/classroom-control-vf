class nginx {
  $wwwdir = "/var/www"
  $nginxpath = "/etc/nginx"
  
  File {
    owner =>  'root',
    group =>  'root',
    mode  =>  '0644',
  }

  package { 'nginx':
    ensure  =>  present,
  }

  file { "${nginxpath}/nginx.conf":
    ensure  => file,
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify  =>  Service['nginx'],
  }
  
  file { "${nginxpath}/conf.d/defalt.conf":
    ensure  => file,
    source  =>  'puppet:///modules/nginx/default.conf',
    require =>  Package['nginx'],
    notify  =>  Service['nginx'],
  }
  
  service { 'nginx':
    ensure  =>  running,
  }
  
  file { "${wwwdir}":
    ensure  => directory,
  }

  file { "${wwwdir}/index.html":
    ensure  => file,
    source  => 'puppet:///modules/nginx/index.html',
    require =>  File["${wwwdir}"],
  }

}
