Class {
	#name : #FiExcludeKey,
	#superclass : #FiDictionaryEdit,
	#category : #'Ficus-Model-Core-Edits'
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

	^ FiDictionaryRemoveEffect builder
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
