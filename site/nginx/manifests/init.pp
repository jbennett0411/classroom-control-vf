class nginx{
  if $is_virtual == true {
    notify { 'This is a virtual machine': }
    notify { '$osfamily': }
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
    subscribe  => File['/etc/nginx/nginx.conf'],
  }
}
