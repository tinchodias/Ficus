Extension { #name : #FiObject }

{ #category : #'*Ficus-Editor' }
FiObject >> editor [
	"Answer a FiObjectEditor associated with this instance."
	
	^ self subclassResponsibility
]
