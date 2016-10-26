class nginx{
  package {'nginx':
    ensure  => present,
  }
  file { '/etc/nginx/nginx.conf':
    ensure   => file,
    source   => 'puppet:///modules/nginx/nginx.conf',
    require  => Package['nginx'],
  }
  file { '/etc/nginx/conf.d/default.conf':
    ensure   => file,
    source   => 'puppet:///modules/nginx/default.conf',
    require  => Package['nginx'],
  }
  file { '/var/www/':
    ensure  => directory,
    owner   => 'www-data',
    group   => 'www-data',
  }
  file { '/var/www/index.html':
    ensure   => file,
    source   => 'puppet:///modules/nginx/index.html',
    require  => File['/var/www'],
  }
  service {'nginx':
    ensure     => running,
    enable     => true,
    subscribe  => File['/etc/nginx/nginx.conf'],
  }
}
