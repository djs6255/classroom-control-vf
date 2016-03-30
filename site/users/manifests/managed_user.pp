define users::managed_user ( String $user ) {
  $userhome = "/home/${user}"
  File {
    owner => "${user}",
    mode  =>  '0644',
  }

  user { "${user}":
    ensure  => present,
  }
  
  file { ["${userhome}","${userhome}/.ssh"]:
    ensure  =>  directory,
  }
}
