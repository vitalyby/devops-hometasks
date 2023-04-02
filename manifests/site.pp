node 'slave2.puppet' {
   include slave2
}

node 'slave1.puppet' {
   include slave1
}

node 'master.puppet' {
   include nginx
   include main

   nginx::resource::server { 'html':
   listen_port => 80,
   proxy       => 'http://192.168.50.5',
   }

   nginx::resource::server { 'php':
   listen_port => 81,
   proxy       => 'http://192.168.50.6',
   }   
}

node default {
   include nginx
   include main
 }

node 'mineserver.puppet' {
   include mineserver
}