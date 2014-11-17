Class {
	#name : #FiReplacement,
	#superclass : #FiEditEffect,
	#instVars : [
		'oldValue',
		'newValue'
	],
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #accessing }
FiReplacement >> edit [
	
	^ oldValue editReplaceBy: newValue
]

{ #category : #accessing }
FiReplacement >> inverse [

	^ newValue editReplaceBy: oldValue
]

{ #category : #accessing }
FiReplacement >> newValue [

	^ newValue
]

{ #category : #accessing }
FiReplacement >> oldValue [

	^ oldValue
]

{ #category : #printing }
FiReplacement >> printOn: aStream [

	super printOn: aStream.

	aStream 
		nextPut: $(;
		nextPutAll: (oldValue printStringLimitedTo: 20);
		nextPutAll: '->';
		nextPutAll: (newValue printStringLimitedTo: 20);
		nextPut: $).
]
