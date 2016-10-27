#resource type
define users::managed_user {
  user { $title: 
    ensure     => present,
    managehome => true,
    group      => $title,
  }
  
  group { $title:
    ensure => present,
  }
  
  file { "/home/$(title)/.ssh":
    ensure => directory,
    owner  => $title,
    mode   => '0700',
  }
  
  file { "/home/$title/.bashrc":
    ensure => file,
    mode   => '0644',
    owner  => $title,
    source => 'puppet:///modules/users/bashrc',
  }
}
