#This function read the content form client
proc readcontent { channel} {
	if { ![eof $channel]} {
		puts [read $channel 4096]
	}
	}


#This function accept client request and invoke readcontent()
proc accept { channel clientaddr clientport } {
	puts $channel
	puts $clientaddr
	puts $clientport
	fconfigure $channel -translation auto -blocking 0 
    fileevent $channel readable [ list readcontent $channel ]
	}


#Create a socket and set port, function
socket -server accept 2345

#wait client
vwait forever
