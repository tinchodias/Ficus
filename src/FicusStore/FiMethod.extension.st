Extension { #name : #FiMethod }

{ #category : #'*FicusStore' }
FiMethod >> ficusInspectorDefinitionString [

	^ '"', self protocol, '"', String cr, self sourceCode 
]

{ #category : #'*FicusStore' }
FiMethod >> ficusInspectorIcon [

	^ Smalltalk ui icons testGreenIcon
]
