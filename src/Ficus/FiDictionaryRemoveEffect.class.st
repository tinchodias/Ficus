Class {
	#name : #FiDictionaryRemoveEffect,
	#superclass : #FiDictionaryEffect,
	#instVars : [
		'oldValue'
	],
	#category : #'Ficus-Model-Effects'
}

{ #category : #accessing }
FiDictionaryRemoveEffect >> edit [
	
	^ FiExcludeKey key: key
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
