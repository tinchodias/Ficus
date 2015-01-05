Class {
	#name : #FiAnyMessageReceiver,
	#superclass : #FiMessageReceiver,
	#category : #'FicusImpact-Requisites'
}

{ #category : #lookup }
FiAnyMessageReceiver >> implementorsOf: aSelector in: aFiRGMethod [

	^ (aFiRGMethod environment implementorsOf: aSelector) select: [ :each | each isProvided ]
]

{ #category : #printing }
FiAnyMessageReceiver >> shortPrintString [

	^ 'any'
]
