Class {
	#name : #FiUpdateEffect,
	#superclass : #FiEditEffect,
	#instVars : [
		'oldValue'
	],
	#category : #'Ficus-Model-Effects'
}

{ #category : #accessing }
FiUpdateEffect >> inverse [

	^ FiAcceptKey 
		key: edit key
		edit: (FiEqual value: oldValue)
]

{ #category : #accessing }
FiUpdateEffect >> oldValue [

	^ oldValue
]

{ #category : #accessing }
FiUpdateEffect >> oldValue: anObject [

	oldValue := anObject
]

{ #category : #printing }
FiUpdateEffect >> printOn: aStream [

	super printOn: aStream.
	
	aStream nextPut: $(.
	edit printOn: aStream.
	
	aStream nextPutAll: ': '.

	aStream 
		nextPutAll: self oldValue printString trimmed;
		nextPut: $).

]
