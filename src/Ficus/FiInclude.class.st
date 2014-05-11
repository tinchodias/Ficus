Class {
	#name : #FiInclude,
	#superclass : #FiSetEdit,
	#category : #'Ficus-Model-Edits'
}

{ #category : #'instance creation' }
FiInclude class >> value: aValue [
	
	^ self new
		theValue: aValue;
		yourself
]

{ #category : #results }
FiInclude >> resultOn: aValue [ 

	^ aValue resultOfInclude: self
]
