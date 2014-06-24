Class {
	#name : #FiExcludeKey,
	#superclass : #FiDictionaryEdit,
	#category : #'Ficus-Model-Edits'
}

{ #category : #'instance creation' }
FiExcludeKey class >> key: aKey [
	
	^ self builder
		key: aKey;
		new
]

{ #category : #effects }
FiExcludeKey >> effectOn: aValue [

	^ aValue effectOfExcludeKey: self
	
]

{ #category : #effects }
FiExcludeKey >> effectRemove: oldValue [

	^ FiRemoveEffect builder
		edit: self;
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
