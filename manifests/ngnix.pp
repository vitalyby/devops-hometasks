class ngnix {
  package { 'nginx':
    ensure => installed,
  }

  file { '/etc/nginx/sites-enabled/default':
          ensure => file,
          source => /etc/puppetlabs/code/environments/main/04-puppet/default,
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