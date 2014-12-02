Class {
	#name : #FiSlotUpdate,
	#superclass : #FiEditEffect,
	#instVars : [
		'slotName',
		'newValue',
		'oldValue',
		'subEffect'
	],
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #converting }
FiSlotUpdate >> asSimpleEffectAt: aBasePath [

	^ { FiUpdate builder 
			path: aBasePath / slotName;
			oldValue: oldValue; 
			newValue: newValue; 
			children: (subEffect asSimpleEffectAt: aBasePath / slotName);
			new }
]

{ #category : #accessing }
FiSlotUpdate >> edit [

	^ FiAcceptSlot 
		slotName: slotName 
		edit: subEffect edit
]

{ #category : #accessing }
FiSlotUpdate >> inverse [

	^ FiAcceptSlot 
		slotName: slotName 
		edit: subEffect inverse
]

{ #category : #enumerating }
FiSlotUpdate >> leafEffectsDo: aBlockClosure basePath: aPath [ 

	^ subEffect 
		leafEffectsDo: aBlockClosure 
		basePath: aPath / slotName
]

{ #category : #accessing }
FiSlotUpdate >> newValue [

	^ newValue
]

{ #category : #accessing }
FiSlotUpdate >> oldValue [

	^ oldValue
]

{ #category : #printing }
FiSlotUpdate >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: slotName;
		nextPut: $).
]

{ #category : #accessing }
FiSlotUpdate >> slotName [

	^ slotName
]

{ #category : #accessing }
FiSlotUpdate >> subEffect [

	^ subEffect
]
