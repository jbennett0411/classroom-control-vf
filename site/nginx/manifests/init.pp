class nginx{
  $root = undef,
  case $::osfamily {
    'debian': {
      $nginx_pkg = 'nginx'
      $nginx_service = 'nginx'
      $nginx_conf = '/etc/nginx/nginx.conf'
      $default_conf = '/etc/nginx/conf.d/default.conf'
      $default_docroot = '/var/www/'
      $index_html = '/var/www/index.html'
      $nginx_epp = 'nginx/nginx.conf.epp'
      $default_epp = 'nginx/default.conf.epp'
      $index_epp = 'nginx/index.html.epp'
      #$root = "root"
      $perm = "0664"
      }
    'redhat': {
      $nginx_pkg = 'nginx'
      $nginx_service = 'nginx'
      $nginx_conf = '/etc/nginx/nginx.conf'
      $default_conf = '/etc/nginx/conf.d/default.conf'
      $default_docroot = '/var/www/'
      $index_html = '/var/www/index.html'
      $nginx_epp = 'nginx/nginx.conf.epp'
      $default_epp = 'nginx/default.conf.epp'
      $index_epp = 'nginx/index.html.epp'
      #$root = "root"
      $perm = "0664"
      }
  }  
  $docroot = $root ? {
    undef => $default_docroot.
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
