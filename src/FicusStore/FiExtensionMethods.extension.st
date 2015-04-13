Extension { #name : #FiExtensionMethods }

{ #category : #'*FicusStore' }
FiExtensionMethods >> ficusInspectorDefinitionString [

	^ self defaultStep, String cr, methods ficusInspectorDefinitionString
]
