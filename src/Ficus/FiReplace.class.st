Class {
	#name : #FiReplace,
	#superclass : #FiEditEffect,
	#instVars : [
		'oldValue',
		'newValue'
	],
	#category : #'Ficus-Model-Effects'
}

{ #category : #accessing }
FiReplace >> edit [
	
	^ oldValue replaceBy: newValue
]

{ #category : #accessing }
FiReplace >> inverse [

	^ newValue replaceBy: oldValue
]

{ #category : #accessing }
FiReplace >> newValue [

	^ newValue
]

{ #category : #accessing }
FiReplace >> oldValue [

	^ oldValue
]

{ #category : #printing }
FiReplace >> printOn: aStream [

	super printOn: aStream.

	aStream 
		nextPut: $(;
		nextPutAll: (oldValue printStringLimitedTo: 20);
		nextPutAll: '->';
		nextPutAll: (newValue printStringLimitedTo: 20);
		nextPut: $).
]
