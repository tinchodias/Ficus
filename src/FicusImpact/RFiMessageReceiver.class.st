Class {
	#name : #RFiMessageReceiver,
	#superclass : #FiFixedObject,
	#classInstVars : [
		'defaultInstance'
	],
	#category : #'FicusImpact-Requisites'
}

{ #category : #accessing }
RFiMessageReceiver class >> defaultInstance [
	
	^ defaultInstance ifNil: [ defaultInstance := self new ]
]

{ #category : #lookup }
RFiMessageReceiver >> implementorsOf: aSelector in: aFiRGMethod [

	^ self subclassResponsibility 
]

{ #category : #printing }
RFiMessageReceiver >> shortPrintString [

	^ self subclassResponsibility 
]
