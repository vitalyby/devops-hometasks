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
    cwd => '/opt/minecraft',
  }  

  file { '/etc/systemd/system/minecraft.service':
    ensure => file,
    source => '/etc/puppetlabs/code/environments/main/manifests/minecraft.service',
  }  

  exec { 'run daemon':
    command => 'systemctl daemon-reload && systemctl start minecraft.service',
  }  
}