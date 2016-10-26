#Manages /etc/skel
class skeleton {
  file { '/etc/skel/.bashrc':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    content => skeleton('files/bashrc'),
  }
}
