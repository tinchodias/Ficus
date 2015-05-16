Class {
	#name : #FiAcceptKey,
	#superclass : #FiDictionaryEdit,
	#instVars : [
		'edit'
	],
	#category : #'FicusExtras-Model-Core-Edits'
}

{ #category : #'instance creation' }
FiAcceptKey class >> key: aKey edit: anEdit [
	
	^ self builder
		key: aKey;
		edit: anEdit;
		new
]

{ #category : #accessing }
FiAcceptKey >> edit [
	
	^ edit
]

{ #category : #effects }
FiAcceptKey >> effectAdd [

	^ FiDictionaryAddition builder
		key: key;
		newValue: edit theValue;
		new
]

{ #category : #effects }
FiAcceptKey >> effectOn: aValue [

	^ aValue effectOfAcceptKey: self
]

{ #category : #effects }
FiAcceptKey >> effectUpdate: oldValue [

	^ FiDictionaryUpdate builder
		key: key;
		oldValue: oldValue;
		newValue: (edit resultOn: oldValue);
		subEffect: (edit effectOn: oldValue);
		new
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
