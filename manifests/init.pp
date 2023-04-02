class nginxserver {
  package { 'nginx':
    ensure => installed,
  }
  
  exec { 'install puppet-nginx':
    command => '/opt/puppetlabs/puppet/bin/puppet module install puppet-nginx --version 4.3.0'
  } 

  exec { 'apply site.pp':
    command => '/opt/puppetlabs/puppet/bin/puppet apply /etc/puppetlabs/code/environments/main/manifests/site.pp'
  } 

  file { '/etc/nginx/sites-enabled/default':
    ensure => file,
    source => '/etc/puppetlabs/code/environments/main/04-puppet/default',
  }  

  service { 'nginx':
    ensure  => true,
    enable  => true,
    require => Package['nginx'],
  }

  exec { 'network':
    command => 'setsebool -P httpd_can_network_connect 1'
  }  

  service { 'firewalld':
    ensure  => 'stopped',
    enable  => false,
  }  

}

class slave2 {
  package { 'httpd':
    ensure => installed,
  }
    package { 'php':
    ensure => installed,
  }

  service { 'httpd':
    ensure  => true,
    enable  => true,
    require => Package['httpd'],
  }

  file { '/var/www/html/index.php':
    ensure => file,
    source => 'https://raw.githubusercontent.com/vitalyby/devops-hometasks/main/03-puppet/index.php',
  }  

  service { 'firewalld':
    ensure  => 'stopped',
    enable  => false,
  }  

  exec { 'edit config httpd.conf':
    command => 'sed -i "s/^    DirectoryIndex index.html$/    DirectoryIndex index.php/g" /etc/httpd/conf/httpd.conf',
    path => "/usr/bin",
  }

  exec { 'restart httpd':
    command => '/bin/systemctl restart sshd.service'
  }

}

class slave1 {
  package { 'httpd':
    ensure => installed,
  }

  service { 'httpd':
    ensure  => true,
    enable  => true,
    require => Package['httpd'],
  }

  file { '/var/www/html/index.html':
    ensure => file,
    source => 'https://raw.githubusercontent.com/vitalyby/devops-hometasks/main/03-puppet/index.html',
  }

  service { 'firewalld':
    ensure  => 'stopped',
    enable  => false,
  }  

}


class mineserver {
  service { 'firewalld':
    ensure  => 'stopped',
    enable  => false,
  }  

}