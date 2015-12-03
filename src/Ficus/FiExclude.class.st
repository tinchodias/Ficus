Class {
	#name : #FiExclude,
	#superclass : #FiSetEdit,
	#category : #'Ficus-Model-Core-Edits'
}

{ #category : #effects }
FiExclude >> changeOn: aValue [

	^ aValue changeOfExclude: self
	
]

{ #category : #effects }
FiExclude >> changeRemove: oldValue [

	^ FiSetRemoval builder
		oldValue: oldValue;
		new
]

{ #category : #results }
FiExclude >> resultOn: aValue [ 

	^ aValue resultOfExclude: self
]
