Class {
	#name : #FiAnyMessageReceiver,
	#superclass : #FiMessageReceiver,
	#category : #'FicusImpact-Dependencies'
}

{ #category : #lookup }
FiAnyMessageReceiver >> implementorsOf: aSelector in: anEnvironment [

	^  anEnvironment implementorsOf: aSelector
]

{ #category : #printing }
FiAnyMessageReceiver >> shortPrintString [

	^ 'any'
]
