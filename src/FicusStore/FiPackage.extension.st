Extension { #name : #FiPackage }

{ #category : #'*FicusStore' }
FiPackage >> ficusInspectorDefinitionString [

	^ 'Package named: ', name, String cr, contents ficusInspectorDefinitionString
]

{ #category : #'*FicusStore' }
FiPackage >> ficusInspectorIcon [

	^ Smalltalk ui icons packageIcon
]
