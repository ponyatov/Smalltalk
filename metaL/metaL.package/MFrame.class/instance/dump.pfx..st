printing
dump: depth pfx: prefix
	| tree |
	" header "
	tree := ( self _pad: depth ) , ( self head: prefix ).
	" return subtree dump "
	^ tree