def broadcast_data (sock, message):
    #Do not send the message to master socket and the client who has send us the message
    for socket in input:
	#don't send message to own and server
        if socket != server and socket != sock :
            try :
                socket.send(message)
            except :
                # broken socket connection may be, chat client pressed ctrl+c for example
                socket.close()
                input.remove(socket)

import socket,select

#create a socket, return a descriptor
server = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
#use descriptor,set socket option
server.setsockopt(socket.SOL_SOCKET,socket.SO_REUSEADDR,1)
#use descriptor,bind ip address and port
#change graceful
server.bind(('',10000))
#listen 
server.listen(10)


#use select handle multiple connections
#input == server "this special descriptor"
input = [server]
while 1:
	#0 represent poll, not wait
	inputfd,outputfd,errorfd=select.select(input,[],[],0)
	for readable in inputfd:
		#if readable == server, there are three conditions(1,2.1,2.2) 
		#1.represent it is ready to accept a new socket
		#we will adding this new socket to list of readable tp moitor
		if readable is server:
			clientsock,clientaddr = readable.accept();
			input.append(clientsock);
			print "Client (%s, %s) connected" % clientaddr
                 	clientsock.send("test\n")
			broadcast_data(clientsock,"[%s:%s] entered room\n" % clientaddr)
		#2.1 established connection client, it send data
		#firstly, we recv this data
		else:
			data = readable.recv(1024);
			if not data:
				#if without data, this connection is ready close
				input.remove(readable);
				broadcast_data(readable,"Client (%s, %s) is offline" % clientaddr)
			else:
				#if data is not empty,we will broadcast
				#we need adding a broadcast funtion
				print data
				broadcast_data(readable,"\r" + '<' + str(readable.getpeername()) + '> ' + data)
