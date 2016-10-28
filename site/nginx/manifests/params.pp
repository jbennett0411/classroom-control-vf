class nginx::params {
  case $::osfamily {
      'debian': {
      $nginx_pkg = 'nginx'
      $nginx_service = 'nginx'
      $nginx_conf = '/etc/nginx/nginx.conf'
      $default_conf = '/etc/nginx/conf.d/default.conf'
      $default_docroot = '/var/www/'
      $index_html = '/var/www/index.html'
      $nginx_epp = 'nginx/nginx.conf.epp'
      $default_epp = 'nginx/default.conf.epp'
      $index_epp = 'nginx/index.html.epp'
      #$root = "root"
      $perm = "0664"
      }
    'redhat': {
      $nginx_pkg = 'nginx'
      $nginx_service = 'nginx'
      $nginx_conf = '/etc/nginx/nginx.conf'
      $default_conf = '/etc/nginx/conf.d/default.conf'
      $default_docroot = '/var/www/'
      $index_html = '/var/www/index.html'
      $nginx_epp = 'nginx/nginx.conf.epp'
      $default_epp = 'nginx/default.conf.epp'
      $index_epp = 'nginx/index.html.epp'
      #$root = "root"
      $perm = "0664"
      }
   }
}
