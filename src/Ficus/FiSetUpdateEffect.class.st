Class {
	#name : #FiSetUpdateEffect,
	#superclass : #FiSetEffect,
	#instVars : [
		'newValue',
		'oldValue',
		'subEffect'
	],
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #accessing }
FiSetUpdateEffect >> edit [
	
	^ self include: newValue
]

{ #category : #summary }
FiSetUpdateEffect >> hierarchicalSummary [

	self flag: #todo. "FIX"
	
	^ {(subEffect isKindOf: FiReplace) 
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
FiSetUpdateEffect >> inverse [

	^ self include: oldValue
]

{ #category : #enumerating }
FiSetUpdateEffect >> leafEffectsDo: aBlockClosure basePath: aPath [ 

	^ subEffect 
		leafEffectsDo: aBlockClosure 
		basePath: aPath / newValue defaultStep

]

{ #category : #accessing }
FiSetUpdateEffect >> newValue [

	^ newValue
]

{ #category : #accessing }
FiSetUpdateEffect >> oldValue [

	^ oldValue
]

{ #category : #accessing }
FiSetUpdateEffect >> subEffect [

	^ subEffect
]
