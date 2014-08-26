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

{ #category : #accessing }
FiSetUpdate >> edit [
	
	^ FiInclude value: newValue
]

{ #category : #summary }
FiSetUpdate >> hierarchicalSummary [

	self flag: #todo. "FIX"
	
	^ {(subEffect isKindOf: FiReplacement) 
		ifTrue: [ 
			FiSummaryUpdate builder 
				step: newValue defaultStep;
				oldValue: subEffect oldValue; 
				newValue: subEffect newValue; 
				subSummary: #();
				new ]	
		ifFalse: [
			FiSummaryUpdate builder 
				step: newValue defaultStep;
				oldValue: oldValue; 
				newValue: newValue; 
				subSummary: subEffect hierarchicalSummary;
				new ]}
]

{ #category : #accessing }
FiSetUpdate >> inverse [

	^ FiInclude value: oldValue
]

{ #category : #enumerating }
FiSetUpdate >> leafEffectsDo: aBlockClosure basePath: aPath [ 

	^ subEffect 
		leafEffectsDo: aBlockClosure 
		basePath: aPath / newValue defaultStep

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
