#proc
proc test  {} {
	puts "ok"
}

#basis
button .t -text "put" -command [list test]


#layout
grid .t
