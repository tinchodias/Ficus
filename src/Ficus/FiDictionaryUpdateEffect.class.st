Class {
	#name : #FiDictionaryUpdateEffect,
	#superclass : #FiDictionaryEffect,
	#instVars : [
		'newValue',
		'oldValue',
		'subEffect'
	],
	#category : #'Ficus-Model-Effects'
}

{ #category : #accessing }
FiDictionaryUpdateEffect >> edit [

	^ FiAcceptKey 
		key: key
		edit: (FiEqual value: newValue)
]

{ #category : #summary }
FiDictionaryUpdateEffect >> hierarchicalSummary [

	self flag: #todo. "FIX"
	
	^ {(subEffect isKindOf: FiReplace) 
		ifTrue: [ 
			FiSummaryUpdate builder 
				step: key;
				oldValue: subEffect oldValue; 
				newValue: subEffect newValue; 
				subSummary: #();
				new ]
		ifFalse: [	
			FiSummaryUpdate builder 
				step: key;
				oldValue: oldValue; 
				newValue: newValue; 
				subSummary: subEffect hierarchicalSummary;
				new ]}
]

{ #category : #accessing }
FiDictionaryUpdateEffect >> inverse [

	^ FiAcceptKey 
		key: key
		edit: (FiEqual value: oldValue)
]

{ #category : #enumerating }
FiDictionaryUpdateEffect >> leafEffectsDo: aBlockClosure basePath: aPath [ 

	^ subEffect 
		leafEffectsDo: aBlockClosure 
		basePath: aPath / key
]

{ #category : #accessing }
FiDictionaryUpdateEffect >> newValue [

	^ newValue
]

{ #category : #accessing }
FiDictionaryUpdateEffect >> oldValue [

	^ oldValue
]

{ #category : #accessing }
FiDictionaryUpdateEffect >> subEffect [

	^ subEffect
]
