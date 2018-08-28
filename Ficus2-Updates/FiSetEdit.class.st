Class {
	#name : #FiSetEdit,
	#superclass : #FiEdit,
	#instVars : [
		'theValue'
	],
	#category : #'Ficus2-Updates-Edits'
}

{ #category : #accessing }
FiSetEdit class >> value: aValue [
	
	^ self builder
		theValue: aValue;
		new
]

{ #category : #printing }
FiSetEdit >> printOn: aStream [

	super printOn: aStream.
	aStream nextPut: $(.
	theValue printOn: aStream.
	aStream nextPut: $).

]

{ #category : #accessing }
FiSetEdit >> step [

	^ theValue defaultStep
]

{ #category : #accessing }
FiSetEdit >> theValue [
	
	^ theValue
]
