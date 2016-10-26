#Manages /etc/skel
class skeleton {
  file { '/etc/skel':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0750',
    content => skeleton('files/bashrc'),
  }
  file { '/etc/skel/.bashrc':
    ensure  =>  file,
    group   => 'root',
    mode    => '0644',
    owner   => 'root',
    source  => 'puppet:///modules/skeleton/bashrc',
  }
}
