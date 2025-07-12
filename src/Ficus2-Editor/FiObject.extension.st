Extension { #name : #FiObject }

{ #category : #'*Ficus2-Editor' }
FiObject >> editor [
	"Answer a FiObjectEditor associated with this instance."
	
	^ self subclassResponsibility
]
