Extension { #name : #FiMethod }

{ #category : #'*FicusStore' }
FiMethod >> ficusInspectorDefinitionString [

	^ '"', protocol, '"', String cr, sourceCode 
]

{ #category : #'*FicusStore' }
FiMethod >> ficusInspectorIcon [

	^ Smalltalk ui icons testGreenIcon
]
