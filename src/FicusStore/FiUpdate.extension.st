Extension { #name : #FiUpdate }

{ #category : #'*FicusStore' }
FiUpdate >> ficusInspectorIcon [

	^ Smalltalk ui icons changeUpdateIcon
]

{ #category : #'*FicusStore' }
FiUpdate >> newValueString [

	^ newValue ficusInspectorDefinitionString
]

{ #category : #'*FicusStore' }
FiUpdate >> oldValueString [

	^ oldValue ficusInspectorDefinitionString
]
