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

{ #category : #accessing }
FiSlotUpdate >> edit [

	^ FiAcceptSlot 
		slotName: slotName 
		edit: subEffect edit
]

{ #category : #summary }
FiSlotUpdate >> hierarchicalSummary [

	self flag: #todo. "FIX"
	
	^ {(subEffect isKindOf: FiReplacement) 
		ifTrue: [ 
			FiSummaryUpdate builder 
				step: slotName;
				oldValue: subEffect oldValue; 
				newValue: subEffect newValue; 
				subSummary: #();
				new ]
		ifFalse: [ 
			FiSummaryUpdate builder 
				step: slotName;
				oldValue: oldValue; 
				newValue: newValue; 
				subSummary: subEffect hierarchicalSummary;
				new ]}
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
