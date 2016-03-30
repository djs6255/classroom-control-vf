class nginx {

  package { 'nginx':
    ensure  =>  present,
  }
  
  file { '/var/www/index.html':
    ensure  => file,
    source  => 'puppet:///nginx/files/index.html',
    require =>  Package['nginx'],
  }

  file { '/etc/nginx/nginx.conf':
    ensure  => file,
    source  => 'puppet:///nginx/files/nginx.conf',
    require => Package['nginx'],
  }
  
  file { '/etc/nginx/conf.d/defalt.conf':
    ensure  => file,
    source  =>  'puppet:///nginx/files/default.conf',
    require =>  Package['nginx'],
  }

}
