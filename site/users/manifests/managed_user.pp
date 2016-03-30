define users::managed_user { String $user
  File {
    owner => "${user}",
    mode  =>  '0644',
  }

  user { "${user}",
    ensure  => present,
  }
  
  file { "/home/${user}":
    ensure  =>  directory,
  }
  
  file { "/home/${user}/.ssh":
    ensure  =>  directory,
  }
}
