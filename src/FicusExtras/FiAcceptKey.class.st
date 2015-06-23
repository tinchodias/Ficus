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

{ #category : #changes }
FiAcceptKey >> changeAdd [

	^ FiDictionaryAddition builder
		key: key;
		newValue: edit theValue;
		new
]

{ #category : #changes }
FiAcceptKey >> changeOn: aValue [

	^ aValue changeOfAcceptKey: self
]

{ #category : #changes }
FiAcceptKey >> changeUpdate: oldValue [

	^ FiDictionaryUpdate builder
		key: key;
		oldValue: oldValue;
		newValue: (edit resultOn: oldValue);
		child: (edit changeOn: oldValue);
		new
]

{ #category : #accessing }
FiAcceptKey >> edit [
	
	^ edit
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
