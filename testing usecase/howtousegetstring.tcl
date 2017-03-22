#Basis Widget 
entry .mesage -textvariable varName
set varName "We will put this strings"

#Layout Widget
grid .mesage

puts [.mesage get]
