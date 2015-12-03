Class {
	#name : #FiEqual,
	#superclass : #FiEdit,
	#instVars : [
		'theValue'
	],
	#category : #'Ficus-Model-Core-Edits'
}

{ #category : #accessing }
FiEqual class >> value: aValue [
	
	^ self builder
		theValue: aValue;
		new
]

{ #category : #effects }
FiEqual >> changeOn: aValue [ 

	^ theValue = aValue
		ifTrue: [ self changeNothing ]
		ifFalse: [ aValue changeOfReplaceBy: theValue ]
]

{ #category : #printing }
FiEqual >> printOn: aStream [

	super printOn: aStream.
	aStream nextPut: $(.
	theValue printOn: aStream.
	aStream nextPut: $).

]

{ #category : #results }
FiEqual >> resultOn: aValue [ 

	^ theValue
]

{ #category : #accessing }
FiEqual >> step [

	^ theValue defaultStep
]

{ #category : #accessing }
FiEqual >> theValue [
	
	^ theValue
]
