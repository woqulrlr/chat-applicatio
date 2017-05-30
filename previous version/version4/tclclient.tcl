#GUI
toplevel .chat
#output GUI
text .chat.displaycontent -width 20 -height 5 -yscrollcommand {.chat.scroll set}
#grid .chat.displaycontent
scrollbar .chat.scroll -command {.chat.displaycontent yview}
grid .chat.displaycontent .chat.scroll -sticky nsew
#grid columnconfigure .chat 0 -weight 1
#grid rowconfigure .chat 0 -weight 1


#input GUI
#Entry Widget:input content
entry .chat.inputcontent
grid .chat.inputcontent
#Button Wigdet:sended message
button .chat.sendbutton -text "Send" -command [list send]
grid .chat.sendbutton


#Function
#receive funcutin 

	set idfy [socket -async 23.105.217.186 10000]
	proc handleComm idfy {
		set mes [gets $idfy]
		.chat.displaycontent insert end "$mes" 
	}   
	fconfigure $idfy -buffering line   
	fileevent $idfy readable [list handleComm $idfy]

#send function
proc send  {} {
	set idfy [socket 23.105.217.186 10000]
	set message [.chat.inputcontent get]
	puts $idfy $message
	flush $idfy
}
