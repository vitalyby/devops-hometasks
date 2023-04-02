node 'slave2.puppet' {
   include slave2
}

node 'slave1.puppet' {
   include slave1
}

node 'master.puppet' {
   include nginx
   include nginxserver
}

node 'mineserver.puppet' {
   include mineserver
}