Class {
	#name : #RFiAnyMessageReceiver,
	#superclass : #RFiMessageReceiver,
	#category : #'FicusImpact-Requisites'
}

{ #category : #lookup }
RFiAnyMessageReceiver >> implementorsOf: aSelector in: aRFiMethod [

	^ (aRFiMethod environment implementorsOf: aSelector) "select: [ :each | each isProvided ]"
]

{ #category : #printing }
RFiAnyMessageReceiver >> shortPrintString [

	^ '*'
]
