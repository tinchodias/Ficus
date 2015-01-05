Class {
	#name : #FiMessageSend,
	#superclass : #FiRequisite,
	#instVars : [
		'receiver',
		'selector'
	],
	#category : #'FicusImpact-Requisites'
}

{ #category : #printing }
FiMessageSend >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		nextPutAll: receiver shortPrintString;
		space;
		print: selector;
		nextPut: $).
]

{ #category : #accessing }
FiMessageSend >> receiver [
	
	^ receiver
]

{ #category : #accessing }
FiMessageSend >> selector [
	
	^ selector
]
