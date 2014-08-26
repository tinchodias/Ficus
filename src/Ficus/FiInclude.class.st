Class {
	#name : #FiInclude,
	#superclass : #FiSetEdit,
	#category : #'Ficus-Model-Core-Edits'
}

{ #category : #'instance creation' }
FiInclude class >> value: aValue [
	
	^ self builder
		theValue: aValue;
		new
]

{ #category : #effects }
FiInclude >> effectAdd [

	^ FiSetAddition builder
		newValue: theValue;
		new
]

{ #category : #effects }
FiInclude >> effectOn: aSet [

	^ aSet effectOfInclude: self
]

{ #category : #effects }
FiInclude >> effectUpdate: oldValue [

	^ FiSetUpdate builder
		newValue: theValue;
		oldValue: oldValue;
		subEffect: (theValue effectOfReplace: oldValue);
		new
]

{ #category : #results }
FiInclude >> resultOn: aValue [ 

	^ aValue resultOfInclude: self
]
