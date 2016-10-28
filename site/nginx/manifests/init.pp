class nginx (
  $root = undef,
  ) (
   $docroot = $nginx::params::docroot,
   $logsdir = $nginx::params::logsdir,
   $confdir = $nginx::params::confdir,
   $blckdir = $nginx::params::blckdir,
   $pkgname = $nginx::params::pkgname,
   $fileown = $nginx::params::fileown,
   $filegrp = $nginx::params::filegrp,
   $svcname = $nginx::params::svcname,
   $svcuser = $nginx::params::svcuser,
   )
{   
   $doc_root = $root ? {
    undef => $default_docroot,
    default => $root,
  }
  
  File {
    ensure => file,
    owner  => root,
    group  => root,
    mode   => $perm,
  }
  package {$nginx_pkg:
    ensure  => present,
  }
  file { $nginx_conf:
    content => epp($nginx_epp),
    require  => Package[$nginx_pkg],
  }
  file { $default_conf:
    content => epp($default_epp),
    require  => Package[$nginx_pkg],
  }
  file { $doc_root:
    ensure  => directory,
  }
  file { $index_html:
    content => epp($index_epp),
    }
  service {$nginx_service:
    ensure     => running,
    enable     => true,
    subscribe  => File[$nginx_conf],
  }
}
