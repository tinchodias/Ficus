Class {
	#name : #FiSuperMessageReceiver,
	#superclass : #FiMessageReceiver,
	#category : #'FicusImpact-Requisites'
}

{ #category : #lookup }
FiSuperMessageReceiver >> implementorsOf: aSelector in: aFiRGMethod [

	^ (aFiRGMethod environment
		lookupImplementorOf: aSelector 
		inSuperclassesOf: aFiRGMethod methodClass
		ifPresent: [ :method | { method } ]
		ifAbsent: [ #() ])
		"select: [ :each | each isProvided ]"
]

{ #category : #printing }
FiSuperMessageReceiver >> shortPrintString [

	^ 'super'
]
