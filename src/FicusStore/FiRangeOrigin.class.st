Class {
	#name : #FiRangeOrigin,
	#superclass : #FiHistoryNodeOrigin,
	#instVars : [
		'fromReference',
		'toReference'
	],
	#category : #'FicusStore-Models'
}

{ #category : #accessing }
FiRangeOrigin >> fromReference [

	^ fromReference
]

{ #category : #printing }
FiRangeOrigin >> printOn: aStream [

	super printOn: aStream.

	aStream 
		nextPut: $(;
		nextPutAll: self fromReference printString;
		nextPut: $:;
		nextPutAll: self toReference printString;
		nextPut: $).
	
]

{ #category : #accessing }
FiRangeOrigin >> toReference [

	^ toReference
]
