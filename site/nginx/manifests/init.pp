class nginx {

  package { 'nginx':
    ensure  =>  present,
  }

  file { '/etc/nginx/nginx.conf':
    ensure  => file,
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify  =>  Service['nginx'].
  }
  
  file { '/etc/nginx/conf.d/defalt.conf':
    ensure  => file,
    source  =>  'puppet:///modules/nginx/default.conf',
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
    source  => 'puppet:///modules/nginx/index.html',
    require =>  File['/var/www'],
  }

}
