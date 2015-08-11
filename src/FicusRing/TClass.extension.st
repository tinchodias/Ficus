Extension { #name : #TClass }

{ #category : #'*FicusRing' }
TClass >> compileAllFrom: oldClass [
	"Recompile all the methods in the receiver's method dictionary (not the
	subclasses). Also recompile the methods in the metaclass."

	super compileAllFrom: oldClass.
	self classSide compileAllFrom: oldClass classSide
]

{ #category : #'*FicusRing' }
TClass >> hasAbstractMethods [
	"Tells whether the receiver locally defines an abstract method, i.e., a method sending subclassResponsibility"
	^ super hasAbstractMethods or: [self classSide hasAbstractMethods]

]

{ #category : #'*FicusRing' }
TClass >> hasMethods [
	"Answer a Boolean according to whether any methods are defined for the 
	receiver (includes whether there are methods defined in the receiver's 
	metaclass)."

	^super hasMethods or: [self classSide hasMethods]
]

{ #category : #'*FicusRing' }
TClass >> reformatAll [ 
	"Reformat all methods in this class.
	Leaves old code accessible to version browsing"
	super reformatAll.		"me..."
	self classSide reformatAll	"...and my metaclass"
]
