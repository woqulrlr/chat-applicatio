#!/usr/local/bin/wish8.5
#set idfy [socket ipaddress port]
#put $idfy "data content"
## author: wn0112@gmail.com

wm geometry . 400x230+450+200
wm title . "LAN\ Chat"
wm minsize . 409 220
wm maxsize . 400 220
wm aspect . 200 120 200 120

set check_os [ array get tcl_platform ]
#MAY BE, copy a array

frame .t -borderwidth 1 -relief groove
pack .t -side right -anchor n

frame .num -borderwidth 2 -relief groove
pack .num -side top -anchor w

frame .f -borderwidth 2 -relief groove
pack .f -side top -anchor w

label .num.ls -text "Talking to:" -anchor nw
label .num.ldate -text "Message:" -anchor nw
if { [ string match *Linux* $check_os ] } {
#retun 1 if match, 0 if no match. HERE, Different OS will use different parameter.
entry .num.s -width 25 -bg white -relief sunken
} elseif { [ string match *osVersion\ 6.1* $check_os ] } {
entry .num.s -width 24 -bg white -relief sunken
} else {
entry .num.s -width 27 -bg white -relief sunken
}

scrollbar .t.scroll -command { .t.log yview }
#Create a scrollbar text widget
set lab [ text .t.log -state disabled -width 26 -height 20 -borderwidth 2 -relief sunken -yscrollcommand { .t.scroll set }]
pack .t.scroll -side right -fill y
pack .t.log -side right -anchor n

if { [ string match *Linux* $check_os ] } {
#Analyze on the previous
$lab config -width 31
}

set entry [ text .f.date -width 19 -height 5 -borderwidth 1 -relief sunken -yscrollcommand { .f.scroll set } ]
scrollbar .f.scroll -command { .f.date yview }
pack .f.scroll -side right -fill y
if { [ string match *Linux* $check_os ] } {
$entry config -width 20
}
button .trans -text "Send" -width 10 -command [ list click_send ]
pack .num.ls .num.s .num.ldate .f.date -anchor nw -pady 3 -ipadx 3
pack .trans -pady 5 -side top -expand true
bind . <Escape> exit
#When we enter <Escape> , app will exit
focus -force .num.s
#app claim computer focus it
$lab config -state normal
if { [ string match *Linux* $check_os ] } {
$lab insert end "*******************************\n"
} elseif { [ string match *osVersion\ 6.1* $check_os ] } {
$lab insert end "**************************\n"
} else {
$lab insert end "**************************\n"
}
$lab insert end "Run this software on other computers,  you can send message to them.\n"
if { [ string match *Linux* $check_os ] } {
$lab insert end "*******************************\n"
} elseif { [ string match *osVersion\ 6.1* $check_os ] } {
$lab insert end "**************************\n"
} else {
$lab insert end "**************************\n"
}
$lab config -state disabled
set remote ""
# client code
proc client { addr { port 2345 } } {
  global lab
  set err [ catch { set connection [ socket $addr $port ]} result ]
  #catch return 0 if there is no erro, and 1 if there is an error
  #connection = channel identifier 
  #socker return a channel identifier, input address port
  #if err != 0, puts error message
  if { $err!=0 } {
  #variable of text-lab
  $lab config -state normal
  $lab insert end "Can't connect to the IP address\n"
  $lab yview moveto 1.0
  $lab config -state disabled
  return -1
  } else {
  return $connection
  }
}

proc send { channel data } {
  global lab entry
  puts $channel $data
  #put "channel identifier" "content"
  flush $channel
  #variable of text-lab
  $lab config -state normal
  $lab insert end "I SAID:\n$data\n"
  $lab yview moveto 1.0
  $lab config -state disabled
  $entry delete 0.0 end
  close $channel
}

proc click_send {} {
global lab
if { [ .num.s get ] !="" } {
#.num.s get mean: content with .num.s 
  set temp [split [.num.s get] .]
#split "comp.lang.tcl.announce" .  -> "." is important
for { set i 0 } { $i < [ llength $temp ] } { incr i } {
  if { [ lindex $temp $i ]>255 || [ lindex $temp $i ]<0 } {
#example: lindex {a b c} 0 -> a
  $lab config -state normal
  $lab insert end "Invalid IP address\n"
  $lab yview moveto 1.0
  $lab config -state disabled
  return
   } elseif { [ llength $temp ]<4 || [ llength $temp ]>4 } {
  $lab config -state normal
  $lab insert end "Invalid IP address\n"
  $lab yview moveto 1.0
  $lab config -state disabled
  return
  }
}
} else {
  $lab config -state normal
  $lab insert end "Please input IP address\n"
  $lab yview moveto 1.0
  $lab config -state disabled
  return
}
  set connection [ client [.num.s get ]]
#Client: This app own function
  if { $connection != -1 } {
  send $connection [ string trimright [.f.date get 0.0 end ] \n ]
#send $connection [xxx] -> puts $channel data
#trimright : "a b c" trim right "b c" = "a"
  }
}

# server code
proc read_data_s { channel } {
global lab a remote
set err [ catch { set data [ read $channel nonewline ] } result ]
#catch return 0 if there is no erro, and 1 if there is an error
#read $channel numBytes/nonewline, choose a split
#if err != 0, puts error message
if { $err!=0 } {
    close $channel
    $lab config -state normal
    $lab insert end "$result\n"
    $lab config -state disabled
} elseif {[ eof $channel ]} {
    close $channel
} else {
    $lab config -state normal
    $lab insert end "$remote SAID:\n$data\n"
    $lab yview moveto 1.0
    $lab config -state disabled
}
}

proc accept { channel addr port } {
  global remote
  set remote $addr
  fconfigure $channel -translation auto -blocking 0 
#channel options
  fileevent $channel readable [ list read_data_s $channel ]
#read_data_s :This app own function
}

proc server { port } {
  socket -server accept $port
}
# monitor port 2345
server 2345
