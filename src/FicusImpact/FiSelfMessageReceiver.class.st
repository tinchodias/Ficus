Class {
	#name : #FiSelfMessageReceiver,
	#superclass : #FiMessageReceiver,
	#category : #'FicusImpact-Dependencies'
}

{ #category : #lookup }
FiSelfMessageReceiver >> implementorsOf: aSelector in: aFiRGMethod [

	^ aFiRGMethod environment
		implementorsOf: aSelector 
		inHierarchyOf: aFiRGMethod methodClass
]

{ #category : #printing }
FiSelfMessageReceiver >> shortPrintString [

	^ 'self'
]
