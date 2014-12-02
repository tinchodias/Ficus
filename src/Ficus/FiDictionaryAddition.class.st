Class {
	#name : #FiDictionaryAddition,
	#superclass : #FiDictionaryEffect,
	#instVars : [
		'newValue'
	],
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #converting }
FiDictionaryAddition >> asSimpleEffectsAt: aBasePath [
	
	^ { newValue 
			ficusDeepCollect: [ :shot :path :collectionFromChildren | 
				FiAddition builder 
					path: path;
					newValue: shot; 
					children: collectionFromChildren;
					new ] 
			basePath: aBasePath / key }
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
