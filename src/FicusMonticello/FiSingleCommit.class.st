Class {
	#name : #FiSingleCommit,
	#superclass : #FiHistoryNodeOrigin,
	#instVars : [
		'reference'
	],
	#category : #'FicusMonticello-Marshaling-New'
}

{ #category : #converting }
FiSingleCommit >> followedBy: aFiCommit [ 
	
	self flag: #todo. "refactor!"
	^ (aFiCommit isKindOf: FiSingleCommit) 
		ifTrue: [	
			FiCommitRange builder
				fromReference: self reference;
				toReference: aFiCommit reference;
				new ]
		ifFalse: [ 
			FiCommitRange builder
				fromReference: self reference;
				toReference: aFiCommit toReference;
				new ]
]

{ #category : #printing }
FiSingleCommit >> printOn: aStream [

	super printOn: aStream.

	aStream 
		nextPut: $(;
		nextPutAll: self reference printString;
		nextPut: $).
	
]

{ #category : #accessing }
FiSingleCommit >> reference [

	^ reference
]

{ #category : #printing }
FiSingleCommit >> shortDescription [

	^ reference name
	
]

{ #category : #accessing }
FiSingleCommit >> someTimeStamp [

	^ reference timeStamp
]
