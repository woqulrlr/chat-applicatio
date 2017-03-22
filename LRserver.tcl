#text widget
text .displaycontent -width 20 -height 5
grid .displaycontent


######Server Basis component############ 
#readcontent
proc readcontent { channel} {
	if { ![eof $channel]} {
		set a [read $channel 4096]
 		.displaycontent insert end "$a\n"
	#	puts [read $channel 4096]
	}  
	}

#accept request from client
proc accept { channel clientaddr clientport } {
	puts $channel
	puts $clientaddr
	puts $clientport
	fconfigure $channel -translation auto -blocking 0 
    fileevent $channel readable [ list readcontent $channel ]
	}

#creat a socket
socket -server accept 2345
vwait forever
