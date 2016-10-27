class nginx{
  case $::osfamily {
    'debian': {
      $nginx_pkg = 'nginx'
      $nginx_service = 'nginx'
    }
    'redhat': {
      $nginx_pkg = 'nginx'
      $nginx_service = 'nginx'
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
  file { '/etc/nginx/nginx.conf':
    source   => 'puppet:///modules/nginx/nginx.conf',
    require  => Package['nginx'],
  }
  file { '/etc/nginx/conf.d/default.conf':
    source   => 'puppet:///modules/nginx/default.conf',
    require  => Package['nginx'],
  }
  file { '/var/www/':
    ensure  => directory,
  }
  file { '/var/www/index.html':
    source   => 'puppet:///modules/nginx/index.html',
  }
  service {$nginx_service:
    ensure     => running,
    enable     => true,
    subscribe  => File['/etc/nginx/nginx.conf'],
  }
}
