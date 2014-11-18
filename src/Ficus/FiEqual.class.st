Class {
	#name : #FiEqual,
	#superclass : #FiObjectEdit,
	#category : #'Ficus-Model-Core-Edits'
}

{ #category : #effects }
FiEqual >> effectOn: aValue [ 

	^ theValue = aValue
		ifTrue: [ self effectNothing ]
		ifFalse: [ aValue effectOfReplaceBy: theValue ]
]

{ #category : #results }
FiEqual >> resultOn: aValue [ 

	^ theValue
]
