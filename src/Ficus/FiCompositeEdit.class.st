Class {
	#name : #FiCompositeEdit,
	#superclass : #FiEdit,
	#instVars : [
		'subEdits'
	],
	#category : #'Ficus-Model-Core-Edits'
}

{ #category : #'instance creation' }
FiCompositeEdit class >> withAll: aCollectionOfEdits [ 

	^ self basicNew
		initializeWithAll: aCollectionOfEdits;
		yourself
]

{ #category : #effects }
FiCompositeEdit >> effectOn: aValue [
	
	^ aValue effectOfCompositeEdit: self
]

{ #category : #initialization }
FiCompositeEdit >> initializeWithAll: aCollectionOfEdits [ 

	self initialize.
	
	subEdits := aCollectionOfEdits
]

{ #category : #printing }
FiCompositeEdit >> printOn: aStream [

	| delimitingBlock |
	super printOn: aStream.

	aStream nextPut: $(.
		
	delimitingBlock := [ aStream cr; tab ].
	delimitingBlock value.

	self subEdits values
		do: [ :each | aStream print: each ]
		separatedBy: delimitingBlock.
		
	aStream nextPut: $).
]

{ #category : #results }
FiCompositeEdit >> resultOn: aShot [ 

	^ aShot resultOfCompositeEdit: self
]

{ #category : #accessing }
FiCompositeEdit >> subEdits [

	^ subEdits
]
