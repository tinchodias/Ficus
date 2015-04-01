Extension { #name : #FiSet }

{ #category : #'*FicusStore' }
FiSet >> ficusInspectorDefinitionString [

	^ '(', self size asString, ' elements)'
]

{ #category : #'*FicusStore' }
FiSet >> ficusInspectorIcon [

	^ Smalltalk ui icons collectionIcon
]
