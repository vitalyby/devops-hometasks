class ngnix {
  package { 'nginx':
    ensure => installed,
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