Class {
	#name : #RFiSuperMessageReceiver,
	#superclass : #RFiMessageReceiver,
	#category : #'FicusImpact-Requisites'
}

{ #category : #lookup }
RFiSuperMessageReceiver >> implementorsOf: aSelector in: aFiRGMethod [

	^ (aFiRGMethod environment
		lookupImplementorOf: aSelector 
		inSuperclassesOf: aFiRGMethod methodClass
		ifPresent: [ :method | { method } ]
		ifAbsent: [ #() ])
		"select: [ :each | each isProvided ]"
]

{ #category : #printing }
RFiSuperMessageReceiver >> shortPrintString [

	^ 'super'
]
