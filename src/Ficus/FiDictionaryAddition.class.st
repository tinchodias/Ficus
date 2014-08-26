Class {
	#name : #FiDictionaryAddition,
	#superclass : #FiDictionaryEffect,
	#instVars : [
		'newValue'
	],
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #accessing }
FiDictionaryAddition >> edit [
	
	^ FiAcceptKey 
		key: key
		edit: (FiEqual value: newValue)
]

{ #category : #summary }
FiDictionaryAddition >> hierarchicalSummary [
	
	^ { newValue 
		ficusDeepCollect: [ :shot :path :collectionFromChildren | 
			FiSummaryAdd builder 
				step: path step;
				newValue: shot; 
				subSummary: collectionFromChildren;
				new ] 
		basePath: FiPath root / key }
]

{ #category : #accessing }
FiDictionaryAddition >> inverse [

	^ FiExcludeKey key: key
]

{ #category : #accessing }
FiDictionaryAddition >> newValue [

	^ newValue
]
