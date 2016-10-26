#Manages /etc/skel
class skeleton {
  file { '/etc/skel':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0750',
    content => skeleton('files/bashrc'),
  }
}
