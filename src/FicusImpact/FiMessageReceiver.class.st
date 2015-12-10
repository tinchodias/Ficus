Class {
	#name : #FiMessageReceiver,
	#superclass : #FiFixedObject,
	#classInstVars : [
		'defaultInstance'
	],
	#category : #'FicusImpact-Requisites'
}

{ #category : #accessing }
FiMessageReceiver class >> defaultInstance [
	
	^ defaultInstance ifNil: [ defaultInstance := self new ]
]

{ #category : #lookup }
FiMessageReceiver >> implementorsOf: aSelector in: aFiRGMethod [

	^ self subclassResponsibility 
]

{ #category : #printing }
FiMessageReceiver >> shortPrintString [

	^ self subclassResponsibility 
]
