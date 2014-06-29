Class {
	#name : #FiDictionaryAddEffect,
	#superclass : #FiDictionaryEffect,
	#instVars : [
		'newValue'
	],
	#category : #'Ficus-Model-Effects'
}

{ #category : #accessing }
FiDictionaryAddEffect >> edit [
	
	^ FiAcceptKey 
		key: key
		edit: (FiEqual value: newValue)
]

{ #category : #summary }
FiDictionaryAddEffect >> hierarchicalSummary [
	
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
FiDictionaryAddEffect >> inverse [

	^ FiExcludeKey key: key
]

{ #category : #accessing }
FiDictionaryAddEffect >> newValue [

	^ newValue
]
