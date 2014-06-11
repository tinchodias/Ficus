Class {
	#name : #FiUpdateEffect,
	#superclass : #FiEditEffect,
	#instVars : [
		'oldValue',
		'subEffect'
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

{ #category : #accessing }
FiUpdateEffect >> subEffect [
	^ subEffect
]

{ #category : #accessing }
FiUpdateEffect >> subEffect: anObject [
	subEffect := anObject
]
