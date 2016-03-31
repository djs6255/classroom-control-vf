class nginx (
  String $package = $nginx::params::package,
  String $fowner = $nginx::params::fowner,
  String $fgroup = $nginx::params::fgroup,
  String $docroot = $nginx::params::docroot,
  String $confdir = $nginx::params::confdir,
  String $srvblkdir = $nginx::params::srvblkdir,
  String $logsdir = $nginx::params::logsdir,
  String $srvname = $nginx::params::srvname,
  String $srvuser = $nginx::params::srvuser,
  )   inherits nginx::params {


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
