Class {
	#name : #FiDictionaryAddition,
	#superclass : #FiDictionaryChange,
	#instVars : [
		'newValue'
	],
	#category : #'Ficus-Dictionary-Changes'
}

{ #category : #converting }
FiDictionaryAddition >> asSimpleChangesAt: aBasePath [
	
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
