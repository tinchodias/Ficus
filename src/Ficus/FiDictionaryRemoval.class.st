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
FiDictionaryRemoval >> hierarchicalSummary [
	
	^ {oldValue 
		ficusDeepCollect: [ :shot :path :collectionFromChildren | 
			FiSummaryRemove builder 
				step: path step;
				oldValue: shot; 
				subSummary: collectionFromChildren;
				new ] 
		basePath: FiPath root / key }
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
