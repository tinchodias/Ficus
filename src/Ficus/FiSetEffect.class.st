Class {
	#name : #FiSetEffect,
	#superclass : #FiEditEffect,
	#instVars : [
		'theValue'
	],
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #edits }
FiSetEffect >> exclude: aValue [

	^ FiExclude value: aValue
]

{ #category : #edits }
FiSetEffect >> include: aValue [

	^ FiInclude value: aValue
]

{ #category : #printing }
FiSetEffect >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		nextPutAll: (theValue printStringLimitedTo: 30);
		nextPut: $).
]

{ #category : #accessing }
FiSetEffect >> theValue [

	^ theValue
]
