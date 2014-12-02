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
FiDictionaryUpdate >> asSimpleEffectsAt: aBasePath [

	^ { FiUpdate builder 
			path: aBasePath / key;
			oldValue: oldValue; 
			newValue: newValue; 
			children: (subEffect asSimpleEffectsAt: aBasePath / key);
			new } asFiSet
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
