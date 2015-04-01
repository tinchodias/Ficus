Extension { #name : #FiAddition }

{ #category : #'*FicusStore' }
FiAddition >> ficusInspectorIcon [

	^ Smalltalk ui icons changeAddIcon
]

{ #category : #'*FicusStore' }
FiAddition >> newValueString [

	^ newValue ficusInspectorDefinitionString
]
