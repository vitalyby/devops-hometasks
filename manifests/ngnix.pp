class ngnix {
  package { 'nginx':
    ensure => installed,
  }

  exec { 'copy config':
    command => 'cp /etc/puppetlabs/code/environments/main/04-puppet/default /etc/nginx/sites-enabled/default'
  }   

  service { 'nginx':
    ensure  => true,
    enable  => true,
    require => Package['nginx'],
  }

  service { 'firewalld':
    ensure  => 'stopped',
    enable  => false,
  }  
}