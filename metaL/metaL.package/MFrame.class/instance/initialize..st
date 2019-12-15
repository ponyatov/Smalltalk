constructor
initialize: aVal
	val  := aVal.
	slot := Dictionary new.
	nest := OrderedCollection new.
	^ self