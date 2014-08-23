"
I represent an abstract edit on a shot. 

See the class comment in FiShot.
"
Class {
	#name : #FiEdit,
	#superclass : #FiFixedObject,
	#category : #'Ficus-Model-Core-Edits'
}

{ #category : #testing }
FiEdit >> affects: aPath [ 
	
	^ true
]

{ #category : #effects }
FiEdit >> effectNothing [

	^ FiNoEffect new
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
