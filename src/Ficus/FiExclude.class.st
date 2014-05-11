Class {
	#name : #FiExclude,
	#superclass : #FiSetEdit,
	#category : #'Ficus-Model-Edits'
}

{ #category : #'instance creation' }
FiExclude class >> value: aValue [
	
	^ self new
		theValue: aValue;
		yourself
]

{ #category : #results }
FiExclude >> resultOn: aValue [ 

	^ aValue resultOfExclude: self
]
