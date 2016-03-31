class wordpress {
  #mysql server
  
  class { 'mysql' : }
  
  #wordpress config
  
  #apache host config
  class { 'apache' : }
  
  #setup config
  class { '::wordpress'  }
  
  #local user for wordpress
  
  #local grop for wordpress
  
}
