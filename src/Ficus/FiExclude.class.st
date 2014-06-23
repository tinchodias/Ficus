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

{ #category : #effects }
FiExclude >> effectOn: aValue [

	^ aValue effectOfExclude: self
	
]

{ #category : #effects }
FiExclude >> effectRemove: oldValue [

	^ FiRemoveEffect new
		edit: self;
		oldValue: oldValue;
		yourself
]

{ #category : #results }
FiExclude >> resultOn: aValue [ 

	^ aValue resultOfExclude: self
]
