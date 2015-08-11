Class {
	#name : #FiExclude,
	#superclass : #FiSetEdit,
	#category : #'Ficus-Model-Core-Edits'
}

{ #category : #effects }
FiExclude >> effectOn: aValue [

	^ aValue effectOfExclude: self
	
]

{ #category : #effects }
FiExclude >> effectRemove: oldValue [

	^ FiSetRemoval builder
		oldValue: oldValue;
		new
]

{ #category : #results }
FiExclude >> resultOn: aValue [ 

	^ aValue resultOfExclude: self
]
