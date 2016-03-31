class nginx::params {

    case $::osfamily {
    'RedHat':   {
      $package = 'nginx'
      $fowner = 'root'
      $fgroup = 'root'
      $docroot = '/var/www'
      $confdir = '/etc/nginx'
      $srvblkdir = "${confdir}/conf.d"
      $logsdir = '/var/log/nginx'
      $srvname = 'nginx'
      $srvuser = 'nginx'
    }
    'Debian':   {
      $package = 'nginx'
      $fowner = 'root'
      $fgroup = 'root'
      $docroot = '/var/www'
      $confdir = '/etc/nginx'
      $srvblkdir = "${confdir}/conf.d"
      $logsdir = '/var/log/nginx'
      $srvname = 'nginx'
      $srvuser = 'www-data'
    }
    'Windows':  {
      $package = 'nginx-service'
      $fowner = 'Administrator'
      $fgroup = 'Administrator'
      $confdir = 'C:/ProgramData/nginx'
      $docroot = '${confdir}/html'
      $srvblkdir = "${confdir}/conf.d"
      $logsdir = '${confdir}/logs'
      $srvname = 'nginx'
      $srvuser = 'nobody'
    }
    default:    {
      fail("OS Family ${::osfamily} is not supported")
    }
  }
}
