Class {
	#name : #FiSlotUpdateEffect,
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
FiSlotUpdateEffect >> edit [

	^ FiAcceptSlot 
		slotName: slotName 
		edit: subEffect edit
]

{ #category : #summary }
FiSlotUpdateEffect >> hierarchicalSummary [

	self flag: #todo. "FIX"
	
	^ {(subEffect isKindOf: FiReplace) 
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
FiSlotUpdateEffect >> inverse [

	^ FiAcceptSlot 
		slotName: slotName 
		edit: subEffect inverse
]

{ #category : #enumerating }
FiSlotUpdateEffect >> leafEffectsDo: aBlockClosure basePath: aPath [ 

	^ subEffect 
		leafEffectsDo: aBlockClosure 
		basePath: aPath / slotName
]

{ #category : #accessing }
FiSlotUpdateEffect >> newValue [

	^ newValue
]

{ #category : #accessing }
FiSlotUpdateEffect >> oldValue [

	^ oldValue
]

{ #category : #printing }
FiSlotUpdateEffect >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: slotName;
		nextPut: $).
]

{ #category : #accessing }
FiSlotUpdateEffect >> slotName [

	^ slotName
]

{ #category : #accessing }
FiSlotUpdateEffect >> subEffect [

	^ subEffect
]
