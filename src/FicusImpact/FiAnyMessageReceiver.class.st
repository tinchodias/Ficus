Class {
	#name : #FiAnyMessageReceiver,
	#superclass : #FiMessageReceiver,
	#category : #'FicusImpact-Dependencies'
}

{ #category : #'as yet unclassified' }
FiAnyMessageReceiver >> implementorsOf: aSelector in: anEnvironment [

	^  anEnvironment implementorsOf: aSelector
]
