Extension { #name : #FiRemoval }

{ #category : #'*FicusStore' }
FiRemoval >> ficusInspectorIcon [

	^ Smalltalk ui icons changeRemoveIcon
]

{ #category : #'*FicusStore' }
FiRemoval >> oldValueString [

	^ oldValue storeString
]
