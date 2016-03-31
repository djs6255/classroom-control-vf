class nginx ( String $root = '/var/www' ) {
  include nginx::params

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
    content =>  template('nginx/nginx.conf.erb'),
    require => Package["${package}"],
    notify  =>  Service["${srvname}"],
  }
  
  file { "${srvblkdir}/defalt.conf":
    ensure  => file,
    content =>  template('nginx/default.conf.erb'),
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
