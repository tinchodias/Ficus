Class {
	#name : #RFiSelfMessageReceiver,
	#superclass : #RFiMessageReceiver,
	#category : #'FicusImpact-Requisites'
}

{ #category : #lookup }
RFiSelfMessageReceiver >> implementorsOf: aSelector in: aRFiMethod [

	^ (aRFiMethod environment
		implementorsOf: aSelector 
		inHierarchyOf: aRFiMethod methodClass)
		"select: [ :each | each isProvided ]"
]

{ #category : #printing }
RFiSelfMessageReceiver >> shortPrintString [

	^ 'self'
]
