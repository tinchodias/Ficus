Class {
	#name : #FiSetUpdateEffect,
	#superclass : #FiSetEffect,
	#instVars : [
		'oldValue',
		'subEffect'
	],
	#category : #'Ficus-Model-Effects'
}

{ #category : #accessing }
FiSetUpdateEffect >> edit [
	
	^ self include: theValue
]

{ #category : #summary }
FiSetUpdateEffect >> hierarchicalSummary [

	self flag: #todo. "FIX"
	
	^ {(subEffect isKindOf: FiReplace) 
		ifTrue: [ 
			FiSummaryUpdate builder 
				step: theValue defaultStep;
				oldValue: subEffect oldValue; 
				newValue: subEffect newValue; 
				subSummary: #();
				new ]	
		ifFalse: [
			FiSummaryUpdate builder 
				step: theValue defaultStep;
				oldValue: oldValue; 
				newValue: theValue; 
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
		basePath: aPath / theValue defaultStep

]

{ #category : #accessing }
FiSetUpdateEffect >> oldValue [

	^ oldValue
]

{ #category : #accessing }
FiSetUpdateEffect >> subEffect [

	^ subEffect
]
