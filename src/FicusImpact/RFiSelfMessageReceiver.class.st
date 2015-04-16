Class {
	#name : #RFiSelfMessageReceiver,
	#superclass : #RFiMessageReceiver,
	#category : #'FicusImpact-Requisites'
}

{ #category : #lookup }
RFiSelfMessageReceiver >> implementorsOf: aSelector in: aFiRGMethod [

	^ (aFiRGMethod environment
		implementorsOf: aSelector 
		inHierarchyOf: aFiRGMethod methodClass)
		"select: [ :each | each isProvided ]"
]

{ #category : #printing }
RFiSelfMessageReceiver >> shortPrintString [

	^ 'self'
]
