class nginx {

  package { 'nginx':
    ensure  =>  present,
  }

  file { '/etc/nginx/nginx.conf':
    ensure  => file,
    source  => 'puppet:///nginx/files/nginx.conf',
    require => Package['nginx'],
    notify  =>  Service['nginx'].
  }
  
  file { '/etc/nginx/conf.d/defalt.conf':
    ensure  => file,
    source  =>  'puppet:///nginx/files/default.conf',
    require =>  Package['nginx'],
    notify  =>  Service['nginx'].
  }
  
  service { 'nginx':
    ensure  =>  present,
  }
  
  file { '/var/www/':
    ensure  => directory,
  }

  file { '/var/www/index.html':
    ensure  => file,
    source  => 'puppet:///nginx/files/index.html',
    require =>  File['/var/www'],
  }

}
