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

  package { 'java-17-openjdk.x86_64':
    ensure => installed,
  } 

  file { '/opt/minecraft':
    ensure => 'directory',
  }

  file { '/opt/minecraft/server.jar':
    ensure => file,
    source => 'https://piston-data.mojang.com/v1/objects/8f3112a1049751cc472ec13e397eade5336ca7ae/server.jar',
  }  

  file { '/opt/minecraft/eula.txt':
    ensure => present,
  }->
  file_line { 'edit eula.txt':
    path => '/opt/minecraft/eula.txt',  
    line => 'eula=true',
    match   => "^eula=false$",
  }  

  exec { 'compile server minecraft':
    command => '/usr/bin/java -Xmx1024M -Xms1024M -jar /opt/minecraft/server.jar nogui',
    path    => '/opt/minecraft',
  }  

}