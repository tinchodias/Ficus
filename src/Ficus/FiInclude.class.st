Class {
	#name : #FiInclude,
	#superclass : #FiSetEdit,
	#category : #'Ficus-Model-Edits'
}

{ #category : #'instance creation' }
FiInclude class >> value: aValue [
	
	^ self builder
		theValue: aValue;
		new
]

{ #category : #effects }
FiInclude >> effectAdd [

	self flag: #todo. "Copy&pasted from FiAcceptKey"

	^ FiAddEffect builder
		edit: self;
		new
]

{ #category : #effects }
FiInclude >> effectOn: aSet [

	^ aSet effectOfInclude: self
]

{ #category : #results }
FiInclude >> resultOn: aValue [ 

	^ aValue resultOfInclude: self
]
