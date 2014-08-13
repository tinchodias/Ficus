Class {
	#name : #FiCommitRange,
	#superclass : #FiHistoryNodeOrigin,
	#instVars : [
		'fromReference',
		'toReference'
	],
	#category : #'FicusMonticello-Marshaling-New'
}

{ #category : #accessing }
FiCommitRange >> fromReference [

	^ fromReference
]

{ #category : #printing }
FiCommitRange >> printOn: aStream [

	super printOn: aStream.

	aStream 
		nextPut: $(;
		nextPutAll: self fromReference printString;
		nextPut: $:;
		nextPutAll: self toReference printString;
		nextPut: $).
	
]

{ #category : #accessing }
FiCommitRange >> someTimeStamp [

	^ toReference timeStamp
]

{ #category : #accessing }
FiCommitRange >> toReference [

	^ toReference
]
