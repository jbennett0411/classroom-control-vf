class nginx (
   $doc_root = $nginx::params::default_docroot,
   $nginx_conf = $nginx::params::nginx_conf,
   $default_conf = $nginx::params::default_conf,
   $nginx_pkg = $nginx::params::nginx_pkg,
   $index_html = $nginx::params::index_html,
   $nginx_epp = $nginx::params::nginx_epp,
   $default_epp = $nginx::params::default_epp,
   $index_epp = $nginx::params::index_epp,
   $nginx_service = $nginx::params::nginx_service,
   ) inherits nginx::params {   
    
  File {
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0664',
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
