Class {
	#name : #FiDictionaryEdit,
	#superclass : #FiEdit,
	#instVars : [
		'key'
	],
	#category : #'Ficus-Model-Edits'
}

{ #category : #'instance creation' }
FiDictionaryEdit class >> key: aKey [
	
	^ self new
		key: aKey;
		yourself
]

{ #category : #accessing }
FiDictionaryEdit >> key [

	^ key
]

{ #category : #accessing }
FiDictionaryEdit >> key: anObject [

	key := anObject
]
