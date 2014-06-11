Class {
	#name : #FiEqual,
	#superclass : #FiObjectEdit,
	#category : #'Ficus-Model-Edits'
}

{ #category : #'instance creation' }
FiEqual class >> value: aValue [
	
	^ self new
		theValue: aValue;
		yourself
]

{ #category : #effects }
FiEqual >> effectOn: aValue [ 

	^ theValue = aValue
		ifTrue: [ self effectNothing ]
		ifFalse: [ self effectReplace: aValue ]
]

{ #category : #results }
FiEqual >> resultOn: aValue [ 

	^ theValue
]
