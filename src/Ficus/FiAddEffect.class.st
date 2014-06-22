Class {
	#name : #FiAddEffect,
	#superclass : #FiEditEffect,
	#category : #'Ficus-Model-Effects'
}

{ #category : #accessing }
FiAddEffect >> inverse [

	^ FiExcludeKey 
		key: edit key
]

{ #category : #enumerating }
FiAddEffect >> leafEffectsDo: aBlockClosure basePath: aPath [ 
	
	^ aBlockClosure 
		value: self 
		value: aPath
]

{ #category : #printing }
FiAddEffect >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		nextPutAll: edit printString trimmed;
		nextPut: $).
]
