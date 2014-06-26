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

{ #category : #accessing }
FiDictionaryAddEffect >> inverse [

	^ FiExcludeKey key: key
]

{ #category : #accessing }
FiDictionaryAddEffect >> newValue [

	^ newValue
]
