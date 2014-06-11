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

{ #category : #effects }
FiInclude >> effectAdd [

	self flag: #todo. "Copy&pasted from FiAcceptKey"

	^ FiAddEffect new
		edit: self;
		yourself
]

{ #category : #effects }
FiInclude >> effectOn: aSet [

	^ aSet effectOfInclude: self
]

{ #category : #results }
FiInclude >> resultOn: aValue [ 

	^ aValue resultOfInclude: self
]
