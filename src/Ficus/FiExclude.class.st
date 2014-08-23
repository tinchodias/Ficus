Class {
	#name : #FiExclude,
	#superclass : #FiSetEdit,
	#category : #'Ficus-Model-Core-Edits'
}

{ #category : #'instance creation' }
FiExclude class >> value: aValue [
	
	^ self builder
		theValue: aValue;
		new
]

{ #category : #effects }
FiExclude >> effectOn: aValue [

	^ aValue effectOfExclude: self
	
]

{ #category : #effects }
FiExclude >> effectRemove: oldValue [

	^ FiSetRemoveEffect builder
		theValue: oldValue;
		new
]

{ #category : #results }
FiExclude >> resultOn: aValue [ 

	^ aValue resultOfExclude: self
]
