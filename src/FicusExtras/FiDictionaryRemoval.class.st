Class {
	#name : #FiDictionaryRemoval,
	#superclass : #FiDictionaryEffect,
	#instVars : [
		'oldValue'
	],
	#category : #'FicusExtras-Model-Core-Effects'
}

{ #category : #converting }
FiDictionaryRemoval >> asSimpleEffectsAt: aBasePath [
	
	^ { oldValue 
			ficusDeepCollect: [ :shot :path :collectionFromChildren | 
				FiRemoval builder 
					path: path;
					oldValue: shot; 
					children: collectionFromChildren asFiSet;
					new ] 
			basePath: aBasePath / key } asFiSet
]

{ #category : #accessing }
FiDictionaryRemoval >> edit [
	
	^ FiExcludeKey key: key
]

{ #category : #accessing }
FiDictionaryRemoval >> inverse [

	^ FiAcceptKey 
		key: key
		edit: (FiEqual value: oldValue)
]

{ #category : #accessing }
FiDictionaryRemoval >> oldValue [

	^ oldValue
]
