Class {
	#name : #FiAcceptKey,
	#superclass : #FiDictionaryEdit,
	#instVars : [
		'edit'
	],
	#category : #'Ficus-Model-Edits'
}

{ #category : #'instance creation' }
FiAcceptKey class >> key: aKey edit: anEdit [
	
	^ self new
		key: aKey;
		edit: anEdit;
		yourself
]

{ #category : #accessing }
FiAcceptKey >> edit [
	
	^ edit
]

{ #category : #accessing }
FiAcceptKey >> edit: anEdit [
	
	edit := anEdit
]

{ #category : #effects }
FiAcceptKey >> effectAdd [

	^ FiAddEffect new
		edit: self;
		yourself
]

{ #category : #effects }
FiAcceptKey >> effectOn: aValue [

	^ aValue effectOfAcceptKey: self
]

{ #category : #effects }
FiAcceptKey >> effectUpdate: oldValue [

	^ FiUpdateEffect new
		edit: self;
		oldValue: oldValue;
		subEffect: (edit effectOn: oldValue);
		yourself
]

{ #category : #printing }
FiAcceptKey >> printOn: aStream [

	super printOn: aStream.
	
	aStream nextPut: $(.

	self key printOn: aStream.

	aStream 
		nextPutAll: '->';
		nextPutAll: edit printString trimmed;
		nextPut: $).
]

{ #category : #results }
FiAcceptKey >> resultOn: aValue [ 

	^ aValue resultOfAcceptKey: self
	
]

{ #category : #accessing }
FiAcceptKey >> step [
	
	^ key
]
