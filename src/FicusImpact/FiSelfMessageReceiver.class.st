Class {
	#name : #FiSelfMessageReceiver,
	#superclass : #FiMessageReceiver,
	#category : #'FicusImpact-Requisites'
}

{ #category : #lookup }
FiSelfMessageReceiver >> implementorsOf: aSelector in: aFiRGMethod [

	^ (aFiRGMethod environment
		implementorsOf: aSelector 
		inHierarchyOf: aFiRGMethod methodClass)
		"select: [ :each | each isProvided ]"
]

{ #category : #printing }
FiSelfMessageReceiver >> shortPrintString [

	^ 'self'
]
