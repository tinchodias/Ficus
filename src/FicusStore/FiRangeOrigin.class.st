Class {
	#name : #FiRangeOrigin,
	#superclass : #FiHistoryNodeOrigin,
	#instVars : [
		'fromReference',
		'toReference'
	],
	#category : #'FicusStore-History-Models'
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
FiRangeOrigin >> someTimeStamp [

	^ toReference timeStamp
]

{ #category : #accessing }
FiRangeOrigin >> toReference [

	^ toReference
]
