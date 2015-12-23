Class {
	#name : #RFiSuperMessageReceiver,
	#superclass : #RFiMessageReceiver,
	#category : #'FicusImpact-Model'
}

{ #category : #lookup }
RFiSuperMessageReceiver >> implementorsOf: aSelector in: aRFiMethod [

	^ (aRFiMethod environment
		lookupImplementorOf: aSelector 
		inSuperclassesOf: aRFiMethod methodClass
		ifPresent: [ :method | { method } ]
		ifAbsent: [ #() ])
		"select: [ :each | each isProvided ]"
]

{ #category : #printing }
RFiSuperMessageReceiver >> shortPrintString [

	^ 'super'
]
