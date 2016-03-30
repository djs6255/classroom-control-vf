define users::managed_user {
  $username = $title
  $userhome = "/home/${username}"
  File {
    owner => "${username}",
    mode  =>  '0644',
  }

  user { "${username}":
    ensure  => present,
  }
  
  file { ["${userhome}","${userhome}/.ssh"]:
    ensure  =>  directory,
  }
}
