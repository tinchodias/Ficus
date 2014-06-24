Class {
	#name : #FiObjectEdit,
	#superclass : #FiEdit,
	#instVars : [
		'theValue'
	],
	#category : #'Ficus-Model-Edits'
}

{ #category : #'instance creation' }
FiObjectEdit class >> value: aValue [
	
	^ self new
		theValue: aValue;
		yourself
]

{ #category : #printing }
FiObjectEdit >> printOn: aStream [

	super printOn: aStream.
	aStream nextPut: $(.
	theValue printOn: aStream.
	aStream nextPut: $).

]

{ #category : #accessing }
FiObjectEdit >> step [

	^ theValue defaultStep
]

{ #category : #accessing }
FiObjectEdit >> theValue [
	
	^ theValue
]
