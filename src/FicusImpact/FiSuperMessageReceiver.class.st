Class {
	#name : #FiSuperMessageReceiver,
	#superclass : #FiMessageReceiver,
	#category : #'FicusImpact-Requisites'
}

{ #category : #lookup }
FiSuperMessageReceiver >> implementorsOf: aSelector in: aFiRGMethod [

	^ aFiRGMethod environment
		lookupImplementorOf: aSelector 
		inSuperclassesOf: aFiRGMethod methodClass
		ifPresent: [ :method | { method } ]
		ifAbsent: [ #() ]

]

{ #category : #printing }
FiSuperMessageReceiver >> shortPrintString [

	^ 'super'
]
