#set a parameter idfy,we use idfy to sotre socket descriptor.  
set idfy [socket 192.168.1.106  2345]

#put ; socket descriptor ; message content     
puts $idfy "testing content"

#flush
flush $idfy
