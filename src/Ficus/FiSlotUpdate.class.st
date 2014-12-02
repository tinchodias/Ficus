Class {
	#name : #FiSlotUpdate,
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
FiSlotUpdate >> asSimpleEffectsAt: aBasePath [

	^ { FiUpdate builder 
			path: aBasePath / slotName;
			oldValue: oldValue; 
			newValue: newValue; 
			children: (subEffect asSimpleEffectsAt: aBasePath / slotName);
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
