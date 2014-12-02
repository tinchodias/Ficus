Class {
	#name : #FiFixedObjectUpdate,
	#superclass : #FiEffect,
	#instVars : [
		'slotName',
		'newValue',
		'oldValue',
		'subEffect'
	],
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #converting }
FiFixedObjectUpdate >> asSimpleEffectsAt: aBasePath [

	^ { FiUpdate builder 
			path: aBasePath / slotName;
			oldValue: oldValue; 
			newValue: newValue; 
			children: (subEffect asSimpleEffectsAt: aBasePath / slotName);
			new } asFiSet
]

{ #category : #accessing }
FiFixedObjectUpdate >> edit [

	^ FiFixedObjectAccept 
		slotName: slotName 
		edit: subEffect edit
]

{ #category : #accessing }
FiFixedObjectUpdate >> inverse [

	^ FiFixedObjectAccept 
		slotName: slotName 
		edit: subEffect inverse
]

{ #category : #accessing }
FiFixedObjectUpdate >> newValue [

	^ newValue
]

{ #category : #accessing }
FiFixedObjectUpdate >> oldValue [

	^ oldValue
]

{ #category : #printing }
FiFixedObjectUpdate >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: slotName;
		nextPut: $).
]

{ #category : #accessing }
FiFixedObjectUpdate >> slotName [

	^ slotName
]

{ #category : #accessing }
FiFixedObjectUpdate >> subEffect [

	^ subEffect
]
