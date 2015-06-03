"
I represent an instance variable in a class. I have my name and my original index in the class.
"
Class {
	#name : #FiInstanceVariable,
	#superclass : #FiFixedObject,
	#instVars : [
		'index',
		'name'
	],
	#category : #'FicusMetamodel-Core'
}

{ #category : #accessing }
FiInstanceVariable >> index [

	^ index
]

{ #category : #accessing }
FiInstanceVariable >> name [

	^ name
]

{ #category : #printing }
FiInstanceVariable >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.
	name printOn: aStream.
	aStream nextPut: $@.
	index printOn: aStream.
	aStream nextPut: $).

]
