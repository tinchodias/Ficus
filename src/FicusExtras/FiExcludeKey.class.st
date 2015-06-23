Class {
	#name : #FiExcludeKey,
	#superclass : #FiDictionaryEdit,
	#category : #'FicusExtras-Model-Core-Edits'
}

{ #category : #'instance creation' }
FiExcludeKey class >> key: aKey [
	
	^ self builder
		key: aKey;
		new
]

{ #category : #changes }
FiExcludeKey >> changeOn: aValue [

	^ aValue changeOfExcludeKey: self
	
]

{ #category : #changes }
FiExcludeKey >> changeRemove: oldValue [

	^ FiDictionaryRemoval builder
		key: key;
		oldValue: oldValue;
		new
]

{ #category : #printing }
FiExcludeKey >> printOn: aStream [

	super printOn: aStream.
	
	aStream nextPut: $(.
	self key printOn: aStream.
	aStream nextPut: $).

]

{ #category : #results }
FiExcludeKey >> resultOn: aShot [ 

	^ aShot resultOfExcludeKey: self
	
]
