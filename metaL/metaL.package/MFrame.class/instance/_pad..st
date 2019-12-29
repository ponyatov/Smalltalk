printing
_pad: depth
	| s |
	s := String cr.
	depth timesRepeat: [ s := s , String tab ].
	^ s