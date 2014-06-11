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

	^ FiNoEffect new
		edit: self;
		yourself
]

{ #category : #effects }
FiEdit >> effectOn: anObject [ 

	^ self subclassResponsibility
]

{ #category : #effects }
FiEdit >> effectReplace: aValue [ 
	
	^ FiReplace new
		edit: self;
		oldValue: aValue;
		yourself
]

{ #category : #testing }
FiEdit >> isNoEdit [

	^ false
]

{ #category : #results }
FiEdit >> resultOn: aValue [ 

	^ self subclassResponsibility
]
