Class {
	#name : #FiEqual,
	#superclass : #FiObjectEdit,
	#category : #'Ficus-Model-Edits'
}

{ #category : #'instance creation' }
FiEqual class >> value: aValue [
	
	^ self builder
		theValue: aValue;
		new
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
