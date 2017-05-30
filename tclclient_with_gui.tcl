#!/bin/sh
#\
exec tclsh "$0" ${1+"$@"}



wm title . " chat"  
wm minsize . 409 220  
wm maxsize . 700 550  
wm aspect . 200 120 200 120  
wm resizable . 0 0  

 
label .header -text "Hello!Welcome to chatsoftware" -relief groove -height 2  
pack .header -side top -fill x 

frame .function1 -relief groove
pack .function1 -side left -expand 1 -fill both

frame .function1.user  -relief groove -bd 2 
label .function1.user.username -text "User8080(online)" 
label .function1.user.signature -text "have a good day"
label .function1.user.friend -text "(0)"
label .function1.user.email -text "(1)"
button .function1.user.button1 -text "l"  -relief solid -height 10 -width 10 -image [image create photo -file "./photo/favor.png"]
button .function1.user.button2 -text "letter"  -relief solid -height 10 -width 10 -image [image create photo -file "./photo/mail.png"]
button .function1.user.userimage -text ""  -width 60 -height 60 -relief solid -image [image create photo -file "./photo/head.png"] -command WindowHead
pack .function1.user -fill x
pack .function1.user.userimage   -side left  -anchor w
pack .function1.user.username .function1.user.signature  -side top -after .function1.user.userimage -anchor w
pack .function1.user.button1 .function1.user.email .function1.user.button2  .function1.user.friend -padx 2 -side left -after .function1.user.signature

#................connect...........................

#................UI_with_connect...................
frame .function1.connect
pack .function1.connect 

label .function1.connect.ipadretext -text "In put server's IP address"
entry .function1.connect.ipadre -textvariable inputadress
button .function1.connect.connect_ser -text "Connect" -command [list getaddress]
pack .function1.connect.ipadretext 
pack .function1.connect.ipadre .function1.connect.connect_ser -side left -expand 0 -fill both
#...............logic_with_connect.................

proc getaddress {} {
	global ipaddress
	set ipaddress [.function1.connect.ipadre get]
	.function.chat2.message insert end "$ipaddress" 
#	set idfy [socket $ipaddress 10000]
}


#................connect...........................
#左下页面布局
frame .function1.menu
pack .function1.menu -expand 0 
#::ttk::entry .function1.menu.entry1 -textvariable ::txt
ttk::notebook .function1.menu.nb -height 335 -width 200
button .function1.menu.button1 -text "1" -image [image create photo -file "./photo/clock.png"] -command {set item0 [$tree1 insert {} end -text "Online Friend"]}
button .function1.menu.button2 -text "2" -image [image create photo -file "./photo/my.png"] -command addf
button .function1.menu.button3 -text "3" -image [image create photo -file "./photo/person2.png"]
pack .function1.menu.nb  -expand 1  
pack .function1.menu.button1 .function1.menu.button2 .function1.menu.button3 -side left -after .function1.menu.nb -expand 1 -fill x 

#tree
set tree1 [::ttk::treeview .function1.menu.nb.messagev -show tree ]
set tree2 [::ttk::treeview .function1.menu.nb.message1 -show tree]
#tree1
.function1.menu.nb add .function1.menu.nb.messagev -text "Friend List"
.function1.menu.nb add .function1.menu.nb.message1 -text "Other List"
set item1 [$tree1 insert {} end -text "Online Friend"]
set item2 [$tree1 insert $item1  end -text "Family"]
set item3 [$tree1 insert $item2  end -text "Jam"]
set itemonline [$tree1 insert {} end -text "Myfriend"]
set itemonline [$tree1 insert $itemonline  end -text "Susan"]

ttk::scrollbar .function1.menu.nb.messagev.scr1 -command ".function1.menu.nb.messagev yview" 
pack .function1.menu.nb.messagev.scr1 -side right -fill y 


#set item0 [$tree1 insert {} end -text "test"]


#tree3
set fme [ttk::frame .function1.menu.nb.f1]
.function1.menu.nb add $fme -text "family" 
set lbl [ttk::label $fme.lbl -text "Please input some message"]
set txt [ttk::entry $fme.messagext]
set btn [ttk::button $fme.btn -text "Exit" -command {exit}]
grid $lbl $txt 
grid $btn

#right page
frame .function
pack .function  -after .function1 -fill both

frame .function.chat -borderwidth 2 -relief groove 
::ttk::frame .function.chat2 -borderwidth 2   -relief groove 
::ttk::frame .function.chat3 
::ttk::frame .function.chat4 
pack .function.chat .function.chat2 .function.chat3 .function.chat4 -side top -fill x 
label .function.chat.name -text "Peter" -foreground #ff0000 -font [font create -family "Times" -size 16] -compound left
label .function.chat.signature -text "You should know"
button .function.chat.button2 -text "sdas"
menu .m1 -type normal -tearoff 0
.m1 add command -label "1"
.m1 add command -label "2"
ttk::menubutton .function.chat.button1  \
   -text "" \
   -image [image create photo -file "./photo/chat.png"]\
   -compound left \
   -menu .m1 \
   -direction below
grid .function.chat.name .function.chat.signature -row 0 -column 0 -sticky w
grid .function.chat.signature -row 1 -column 0
grid .function.chat.button1  -row 1 -column 9 -sticky e 

#set ::color "#0000a0"
set col "#0000a0"
text .function.chat2.message -foreground $col

pack .function.chat2.message  -fill both -expand 1

#message .function.chat2.message -pady 200 -padx 200 -textvariable ::txt -background #ffffff
#pack .function.chat2.message -expand 1 -fill both

button .function.chat3.button1 -text "font" -image [image create photo -file "./photo/font.png"] -height 20 -width 20 -command opencolor
button .function.chat3.button2 -text "emoji" -image [image create photo -file "./photo/emoji.png"] -height 20 -width 20 
button .function.chat3.button3 -text "pic" -image [image create photo -file "./photo/pic.png"] -height 20 -width 20 -command WindowHead
button .function.chat3.button4 -text "add" -image [image create photo -file "./photo/add.png"] -height 20 -width 20 -command directory
menu .m -type normal -tearoff 0
.m add command -label "过去记录"
.m add command -label "所有记录"
ttk::menubutton .function.chat3.button5  \
   -text "聊天记录" \
   -image [image create photo -file "./photo/chat.png"] \
   -compound left \
   -menu .m \
   -direction below
pack .function.chat3.button1 .function.chat3.button2 .function.chat3.button3 .function.chat3.button4 -side left -fill x
pack .function.chat3.button5 -side right 

entry .function.chat4.entry1 -textvariable inputcontext -relief groove 
button .function.chat4.button1 -text "发送" -relief groove -command {set inputcontext ""} -command [list send]
pack .function.chat4.entry1 -side left -fill x -expand 1
pack .function.chat4.button1 -side right 

#Function
#receive funcutin 

#	global ipaddress
#	set idfy [socket -async $ipaddress 10000]

	set idfy [socket -async 192.168.59.134 10000]
	proc handleComm idfy {
		set mes [gets $idfy]
		.function.chat2.message insert end "$mes" 
		.function.chat2.message insert end "\n" 
	}   
	fconfigure $idfy -buffering line   
	fileevent $idfy readable [list handleComm $idfy]

#send function
proc send  {} {
#	set idfy [socket 10.4.60.58 10000]
	global ipaddress
	set idfy [socket $ipaddress 10000]
	set message [.function.chat4.entry1 get]
	puts $idfy $message
	flush $idfy
}


proc WindowHead {window} {
#   global counter
  # set a .gui[incr counter]
   
toplevel $a
wm title $a "Image edit"
pack [label $a.label -text "ImageEdit"]
pack [button $a.btn1 -image [image create photo -file "C:/Users/admin/Desktop/photo/open.png"] -command open]
pack [button $a.ok -text OK -command [list destroy $a]]
}

proc open {{file ""}} {
set types {
	{ {Image Files}       {*.jpg;*.gif;*.bmp;*.png;*.pcx;*.ico;*.tiff;*.raw;*.ppm}  }
}
set file [tk_getOpenFile -filetypes $types -title openpic]
}

proc opencolor {{color ""}} {
set color [tk_chooseColor \
   -initialcolor "#FF0000" \
   -title "choose color"]

if {$color == ""} {
   puts "no color"
} else {
   puts "choose : $color"
}
}

proc directory {{directory ""}} {
set dir [tk_chooseDirectory \
   -initialdir ~ \
   -title "Choose a directory"]

if {$dir == ""} {
   puts "no directory"
} else {
   puts  "choose: $dir"
}
}

