"
I represent an abstract edit on a shot. 

See the class comment in FiShot.
"
Class {
	#name : #FiEdit,
	#superclass : #FiFixedObject,
	#category : #'Ficus-Model-Core-Edits'
}

{ #category : #convenience }
FiEdit class >> fromAll: edits [

	^ edits
		ifEmpty: [ FiNoEdit new ]
		ifNotEmpty: [ 
			edits size = 1
				ifTrue: [ edits anyOne ]
				ifFalse: [ FiCompositeEdit withAll: edits ] ]
]

{ #category : #convenience }
FiEdit class >> fromAllAssociations: associations [

	| edits |
	edits := associations collect: [ :each |
		FiSubEdit 
			path: each key asFiPath 
			equal: each value ].

	^ self fromAll: edits
]

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
