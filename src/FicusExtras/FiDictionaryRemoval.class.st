Class {
	#name : #FiDictionaryRemoval,
	#superclass : #FiDictionaryChange,
	#instVars : [
		'oldValue'
	],
	#category : #'FicusExtras-Model-Core-Changes'
}

{ #category : #converting }
FiDictionaryRemoval >> asSimpleChangesAt: aBasePath [
	
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
