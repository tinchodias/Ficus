Class {
	#name : #FiMessageSend,
	#superclass : #FiDependency,
	#instVars : [
		'receiver',
		'selector'
	],
	#category : #'FicusImpact-Dependencies'
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
