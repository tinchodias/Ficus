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

{ #category : #results }
FiEqual >> resultOn: aValue [ 

	^ theValue
]
