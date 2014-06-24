Class {
	#name : #FiRemoveEffect,
	#superclass : #FiEditEffect,
	#instVars : [
		'oldValue'
	],
	#category : #'Ficus-Model-Effects'
}

{ #category : #accessing }
FiRemoveEffect >> inverse [

	self flag: #todo. "Does not work when edit is a FiSet's FiExclude"
	^ FiAcceptKey 
		key: edit step
		edit: (FiEqual value: oldValue)
]

{ #category : #enumerating }
FiRemoveEffect >> leafEffectsDo: aBlockClosure basePath: aPath [ 
	
	^ aBlockClosure 
		value: self 
		value: aPath
]

{ #category : #accessing }
FiRemoveEffect >> oldValue [

	^ oldValue
]

{ #category : #printing }
FiRemoveEffect >> printOn: aStream [

	super printOn: aStream.
	
	aStream nextPut: $(.
	edit printOn: aStream.
	
	aStream nextPutAll: ': '.

	aStream 
		nextPutAll: self oldValue printString trimmed;
		nextPut: $).

]
