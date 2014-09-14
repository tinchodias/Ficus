Class {
	#name : #FiDictionaryRemoval,
	#superclass : #FiDictionaryEffect,
	#instVars : [
		'oldValue'
	],
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #accessing }
FiDictionaryRemoval >> edit [
	
	^ FiExcludeKey key: key
]

{ #category : #summary }
FiDictionaryRemoval >> hierarchicalSummaryFrom: aBasePath [
	
	^ {oldValue 
		ficusDeepCollect: [ :shot :path :collectionFromChildren | 
			FiSummaryRemove builder 
				path: path;
				oldValue: shot; 
				subSummary: collectionFromChildren;
				new ] 
		basePath: aBasePath / key }
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
