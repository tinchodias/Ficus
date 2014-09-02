Class {
	#name : #FiHistoryNode,
	#superclass : #FiFixedObject,
	#instVars : [
		'origin'
	],
	#category : #'FicusStore-History-Models'
}

{ #category : #accessing }
FiHistoryNode >> origin [

	^ origin
]

{ #category : #accessing }
FiHistoryNode >> patches [

	^ self shouldBeImplemented 
]

{ #category : #printing }
FiHistoryNode >> printOn: aStream [

	super printOn: aStream.

	aStream 
		nextPut: $(;
		nextPutAll: self origin printString;
		nextPut: $).
	
]

{ #category : #accessing }
FiHistoryNode >> priors [

	^ self shouldBeImplemented 
]

{ #category : #accessing }
FiHistoryNode >> snapshot [

	^ self shouldBeImplemented 
]
