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

	^ self builder
		subEdits: (FiSet withValues: aCollectionOfEdits);
		new
]

{ #category : #effects }
FiCompositeEdit >> effectOn: aValue [
	
	^ aValue effectOfCompositeEdit: self
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
