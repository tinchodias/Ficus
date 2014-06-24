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

{ #category : #enumerating }
FiUpdateEffect >> leafEffectsDo: aBlockClosure basePath: aPath [ 

	^ subEffect 
		leafEffectsDo: aBlockClosure 
		basePath: aPath / edit step

]

{ #category : #accessing }
FiUpdateEffect >> oldValue [

	^ oldValue
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
