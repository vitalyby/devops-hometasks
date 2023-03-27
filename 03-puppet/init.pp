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
          source => 'https://raw.githubusercontent.com/vitalyby/devops-hometasks/main/02-ansible/2/index.html',
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
          source => 'https://raw.githubusercontent.com/vitalyby/devops-hometasks/main/02-ansible/2/index.php',
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
