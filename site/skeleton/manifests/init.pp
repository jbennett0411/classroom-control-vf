#Manages /etc/skel
class skeleton {
  file { '/etc/skel':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    content => skeleton('files/bashrc'),
  }
}
