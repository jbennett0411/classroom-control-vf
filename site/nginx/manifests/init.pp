class nginx{
  case $::osfamily {
    'debian': {
      $nginx_pkg = 'nginx'
      $nginx_service = 'nginx'
      $nginx_conf = '/etc/nginx/nginx.conf'
      $default_conf = '/etc/nginx/conf.d/default.conf'
      $doc_root = '/var/www/'
      $index_html = '/var/www/index.html'
      }
    'redhat': {
      $nginx_pkg = 'nginx'
      $nginx_service = 'nginx'
      $nginx_conf = '/etc/nginx/nginx.conf'
      $default_conf = '/etc/nginx/conf.d/default.conf'
      $doc_root = '/var/www/'
      $index_html = '/var/www/index.html'
      }
  }  
  File {
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
  package {$nginx_pkg:
    ensure  => present,
  }
  file { $nginx_conf:
    #source   => 'puppet:///modules/nginx/nginx.conf',
    content => epp('nginx/nginx.conf.epp'),
    require  => Package[$nginx_pkg],
  }
  file { $default_conf:
    #source   => 'puppet:///modules/nginx/default.conf',
    content => epp('nginx/default.conf.epp'),
    require  => Package[$nginx_pkg],
  }
  file { $doc_root:
    ensure  => directory,
  }
  file { $index_html:
    #source   => 'puppet:///modules/nginx/index.html',
    content => epp('nginx/index.html.epp'),
    }
  service {$nginx_service:
    ensure     => running,
    enable     => true,
    subscribe  => File[$nginx_conf],
  }
}
