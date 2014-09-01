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

{ #category : #accessing }
FiSubEdit >> edit [

	^ edit
]

{ #category : #effects }
FiSubEdit >> effectOn: aValue [
	
	^ aValue effectOfSubEdit: self
]

{ #category : #accessing }
FiSubEdit >> path [

	^ path
]

{ #category : #results }
FiSubEdit >> resultOn: aShot [ 
	
	^ aShot resultOfSubEdit: self
]
