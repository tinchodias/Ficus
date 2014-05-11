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

	^ FiAcceptKey 
		key: edit key
		edit: (FiEqual value: oldValue)
]

{ #category : #accessing }
FiRemoveEffect >> oldValue [

	^ oldValue
]

{ #category : #accessing }
FiRemoveEffect >> oldValue: aValue [

	oldValue := aValue
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
