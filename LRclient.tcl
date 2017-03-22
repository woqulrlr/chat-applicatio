#Entry Widget:input content
entry .inputcontent
grid .inputcontent

#Button Wigdet:sended message
button .sendbutton -text "Send" -command [list send]
grid .sendbutton

#Client baisis component
proc send  {} {
set idfy [socket 192.168.59.134  2345]
set message [.inputcontent get]
puts $idfy $message
flush $idfy
}


