Class {
	#name : #FiSetUpdate,
	#superclass : #FiSetEffect,
	#instVars : [
		'newValue',
		'oldValue',
		'subEffect'
	],
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #converting }
FiSetUpdate >> asSimpleEffectsAt: aBasePath [

	^ { FiUpdate builder 
			path: aBasePath / newValue defaultStep;
			oldValue: oldValue; 
			newValue: newValue; 
			children: (subEffect asSimpleEffectsAt: aBasePath / newValue defaultStep);
			new } asFiSet
]

{ #category : #accessing }
FiSetUpdate >> edit [
	
	self flag: #todo. "Answer a SubEdit when there is a subEffect like FiFixedObjectUpdate"
	^ FiInclude value: newValue
]

{ #category : #accessing }
FiSetUpdate >> inverse [

	^ FiInclude value: oldValue
]

{ #category : #accessing }
FiSetUpdate >> newValue [

	^ newValue
]

{ #category : #accessing }
FiSetUpdate >> oldValue [

	^ oldValue
]

{ #category : #printing }
FiSetUpdate >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		nextPutAll: (subEffect printStringLimitedTo: 30);
		nextPut: $).
]

{ #category : #accessing }
FiSetUpdate >> subEffect [

	^ subEffect
]
