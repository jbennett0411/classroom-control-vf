class nginx{
  case $::osfamily {
  'debian': {
    $service_user = 'www-data'
  }
  'redhat': {
    $service_user = 'nginx'
  }  
  File {
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
  package {'nginx':
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
  service {'nginx':
    ensure     => running,
    enable     => true,
    user       => $service_user,
    subscribe  => File['/etc/nginx/nginx.conf'],
  }
}
