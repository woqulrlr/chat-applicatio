#In ths script, it combines server component and client component

#Server UI
#text widget
text .displaycontent -width 20 -height 5
grid .displaycontent

#Client UI
#Entry Widget:input content
entry .inputcontent -textvariable inputvariable
grid .inputcontent
#Button Wigdet:sended message
button .sendbutton -text "Send" -command [list send] -command {set inputvariable ""}
grid .sendbutton

#Client baisis component
proc send  {} {
set idfy [socket 192.168.1.108  2345]
set message [.inputcontent get]
puts $idfy $message
flush $idfy
}

#Server basis component 
#readcontent from client
proc readcontent { channel} {
	if { ![eof $channel]} {
		set mes [read $channel 4096]
 		.displaycontent insert end "$mes"
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
