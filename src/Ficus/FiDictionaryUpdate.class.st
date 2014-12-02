Class {
	#name : #FiDictionaryUpdate,
	#superclass : #FiDictionaryEffect,
	#instVars : [
		'newValue',
		'oldValue',
		'subEffect'
	],
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #converting }
FiDictionaryUpdate >> asSimpleEffectAt: aBasePath [

	^ { FiUpdate builder 
			path: aBasePath / key;
			oldValue: oldValue; 
			newValue: newValue; 
			children: (subEffect asSimpleEffectAt: aBasePath / key);
			new }
]

{ #category : #accessing }
FiDictionaryUpdate >> edit [

	^ FiAcceptKey 
		key: key
		edit: (FiEqual value: newValue)
]

{ #category : #accessing }
FiDictionaryUpdate >> inverse [

	^ FiAcceptKey 
		key: key
		edit: (FiEqual value: oldValue)
]

{ #category : #enumerating }
FiDictionaryUpdate >> leafEffectsDo: aBlockClosure basePath: aPath [ 

	^ subEffect 
		leafEffectsDo: aBlockClosure 
		basePath: aPath / key
]

{ #category : #accessing }
FiDictionaryUpdate >> newValue [

	^ newValue
]

{ #category : #accessing }
FiDictionaryUpdate >> oldValue [

	^ oldValue
]

{ #category : #accessing }
FiDictionaryUpdate >> subEffect [

	^ subEffect
]
