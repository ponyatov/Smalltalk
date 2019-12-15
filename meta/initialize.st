Frame>>initialize: aVal
	^ self class new initialize: aVal

initialize: aVal
	val  := aVal.
	slot := Dictionary new.
	nest := OrderedCollection new.
	^ self