class aliases (
    $admin = 'root',
) {
    # uses $admin to build the aliases file'
    notify { "The value of admin is ${admin}": }    # uses $admin to build the aliases file
        file { '/etc/aliases':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => epp('aliases/aliases.epp,{$admin = 'root'}'),
    }
    exec { '/usr/bin/newaliases':
        refreshonly => true,
        subscribe   => File['/etc/aliases'],
    }
}
