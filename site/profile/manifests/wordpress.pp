class profile::wordpress {
  #mysql server
  
  class { '::mysql::server' : 
    root_password => 'puppetlabs',
  }
  
  #wordpress config
  
  #apache host config
  class { 'apache' : }
  class { 'apache::mod::php' : }
  
  #setup config
  class { '::wordpress' :
    wp_owner  =>  'wordpress',
    wp_group  =>  'wordpress',
    db_user   =>  'wordpress',
    db_password =>  'wordpress',
    db_host   =>    'localhost',
  }
  
  #local user for wordpress
  user { 'wordpress':
    ensure  => present,
  }
  
  #local group for wordpress
  group { 'wordpress':
    ensure  => 'present',
  }
}
