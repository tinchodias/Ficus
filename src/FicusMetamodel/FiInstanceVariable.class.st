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

{ #category : #'as yet unclassified' }
FiInstanceVariable >> index [

	^ index
]

{ #category : #'as yet unclassified' }
FiInstanceVariable >> name [

	^ name
]
