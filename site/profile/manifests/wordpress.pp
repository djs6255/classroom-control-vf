class profile::wordpress {
  #mysql server
  
  class { 'mysql' : }
  mysql::db { 'wordpress':
    user  =>  'wordpress',
    password  =>  'wordpress',
    host  =>  'localhost',
    grant =>  ['SELECT','UPDATE'],
  }
  
  #wordpress config
  
  #apache host config
  class { 'apache' : }
  
  #setup config
  class { '::wordpress' :
    wp_owner  =>  'wordpress',
    wp_group  =>  'wordpress',
    db_user   =>  'wordpress',
    db_password =>  'wordpress',
  }
  
  #local user for wordpress
  user { 'wordpress':
    ensure  => present,
  }
  
  #local grop for wordpress
  user { 'wordpress':
    ensure  => 'present',
  }
}
