Class {
	#name : #FiDictionaryRemoveEffect,
	#superclass : #FiDictionaryEffect,
	#instVars : [
		'oldValue'
	],
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #accessing }
FiDictionaryRemoveEffect >> edit [
	
	^ FiExcludeKey key: key
]

{ #category : #summary }
FiDictionaryRemoveEffect >> hierarchicalSummary [
	
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
FiDictionaryRemoveEffect >> inverse [

	^ FiAcceptKey 
		key: key
		edit: (FiEqual value: oldValue)
]

{ #category : #accessing }
FiDictionaryRemoveEffect >> oldValue [

	^ oldValue
]
