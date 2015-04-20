Class {
	#name : #RFiMessageSend,
	#superclass : #RFiRequisite,
	#instVars : [
		'receiver',
		'selector'
	],
	#category : #'FicusImpact-Model'
}

{ #category : #printing }
RFiMessageSend >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		nextPutAll: receiver shortPrintString;
		space;
		print: selector;
		nextPut: $).
]

{ #category : #accessing }
RFiMessageSend >> receiver [
	
	^ receiver
]

{ #category : #accessing }
RFiMessageSend >> selector [
	
	^ selector
]

{ #category : #printing }
RFiMessageSend >> shortPrintString [

	^ 'Send ', receiver shortPrintString, ' ', selector
]
