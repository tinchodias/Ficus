Class {
	#name : #FiSingleOrigin,
	#superclass : #FiHistoryNodeOrigin,
	#instVars : [
		'reference'
	],
	#category : #'FicusStore-Models'
}

{ #category : #enumerating }
FiSingleOrigin >> anySatisfy: aBlock [
	
	^ aBlock value: self
]

{ #category : #comparing }
FiSingleOrigin >> contains: anOrigin [ 
	
	^ self = anOrigin
]

{ #category : #converting }
FiSingleOrigin >> followedBy: aFiCommit [ 
	
	self flag: #todo. "refactor!"
	^ (aFiCommit isKindOf: FiSingleOrigin) 
		ifTrue: [	
			FiRangeOrigin builder
				fromReference: self reference;
				toReference: aFiCommit reference;
				new ]
		ifFalse: [ 
			FiRangeOrigin builder
				fromReference: self reference;
				toReference: aFiCommit toReference;
				new ]
]

{ #category : #printing }
FiSingleOrigin >> printOn: aStream [

	super printOn: aStream.

	aStream 
		nextPut: $(;
		nextPutAll: self reference printString;
		nextPut: $).
	
]

{ #category : #accessing }
FiSingleOrigin >> reference [

	^ reference
]

{ #category : #printing }
FiSingleOrigin >> shortDescription [

	^ reference name
	
]

{ #category : #accessing }
FiSingleOrigin >> someTimeStamp [

	^ reference timeStamp
]
