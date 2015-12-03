Class {
	#name : #FiSubEdit,
	#superclass : #FiEdit,
	#instVars : [
		'path',
		'edit'
	],
	#category : #'Ficus-Model-Core-Edits'
}

{ #category : #'instance creation' }
FiSubEdit class >> path: aPath edit: anEdit [ 
	
	^ self builder
		path: aPath;
		edit: anEdit;
		new
]

{ #category : #'instance creation' }
FiSubEdit class >> path: aPath equal: aValue [

	^ self path: aPath edit: (FiEqual value: aValue)
]

{ #category : #effects }
FiSubEdit >> changeOn: aValue [
	
	^ aValue changeOfSubEdit: self
]

{ #category : #accessing }
FiSubEdit >> edit [

	^ edit
]

{ #category : #accessing }
FiSubEdit >> path [

	^ path
]

{ #category : #printing }
FiSubEdit >> printOn: aStream [

	super printOn: aStream.
	aStream nextPut: $(.
	path printOn: aStream.
	aStream nextPut: $).

]

{ #category : #results }
FiSubEdit >> resultOn: aShot [ 
	
	^ aShot resultOfSubEdit: self
]
