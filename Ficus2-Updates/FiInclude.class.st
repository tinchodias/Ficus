Class {
	#name : #FiInclude,
	#superclass : #FiSetEdit,
	#category : #'Ficus2-Updates-Edits'
}

{ #category : #effects }
FiInclude >> changeAdd [

	^ FiSetAddition builder
		newValue: theValue;
		new
]

{ #category : #effects }
FiInclude >> changeOn: aSet [

	^ aSet changeOfInclude: self
]

{ #category : #effects }
FiInclude >> changeUpdate: oldValue [

	^ FiSetUpdate builder
		newValue: theValue;
		oldValue: oldValue;
		child: (oldValue changeOfReplaceBy: theValue);
		new
]

{ #category : #results }
FiInclude >> resultOn: aValue [ 

	^ aValue resultOfInclude: self
]
