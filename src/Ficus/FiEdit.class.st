"
I represent an abstract edit on a shot.
"
Class {
	#name : #FiEdit,
	#superclass : #FiFixedObject,
	#category : #'Ficus-Model-Edits'
}

{ #category : #testing }
FiEdit >> affects: aPath [ 
	
	^ true
]

{ #category : #effects }
FiEdit >> effectNothing [

	^ FiNoEffect builder
		edit: self;
		new
]

{ #category : #effects }
FiEdit >> effectOn: anObject [ 

	^ self subclassResponsibility
]

{ #category : #effects }
FiEdit >> effectReplace: aValue [ 
	
	^ FiReplace builder
		edit: self;
		oldValue: aValue;
		new
]

{ #category : #testing }
FiEdit >> isNoEdit [

	^ false
]

{ #category : #results }
FiEdit >> resultOn: aValue [ 

	^ self subclassResponsibility
]
