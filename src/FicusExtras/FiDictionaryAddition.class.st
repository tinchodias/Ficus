Class {
	#name : #FiDictionaryAddition,
	#superclass : #FiDictionaryEffect,
	#instVars : [
		'newValue'
	],
	#category : #'FicusExtras-Model-Core-Effects'
}

{ #category : #converting }
FiDictionaryAddition >> asSimpleEffectsAt: aBasePath [
	
	^ { newValue 
			ficusDeepCollect: [ :shot :path :collectionFromChildren | 
				FiAddition builder 
					path: path;
					newValue: shot; 
					children: collectionFromChildren asFiSet;
					new ] 
			basePath: aBasePath / key } asFiSet
]

{ #category : #accessing }
FiDictionaryAddition >> edit [
	
	^ FiAcceptKey 
		key: key
		edit: (FiEqual value: newValue)
]

{ #category : #accessing }
FiDictionaryAddition >> inverse [

	^ FiExcludeKey key: key
]

{ #category : #accessing }
FiDictionaryAddition >> newValue [

	^ newValue
]
