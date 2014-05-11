Class {
	#name : #FiEdit,
	#superclass : #FiShot,
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

{ #category : #testing }
FiEdit >> isNoEdit [

	^ false
]

{ #category : #results }
FiEdit >> resultOn: aValue [ 

	^ self subclassResponsibility
]
