"
I am an object used for testing Ficus.
"
Class {
	#name : #FiRecipe,
	#superclass : #FiFixedObject,
	#instVars : [
		'kind',
		'title'
	],
	#category : #'Ficus-Tests-Example'
}

{ #category : #'instance creation' }
FiRecipe class >> title: aTitle kind: aKind [
	
	^ self builder
		title: aTitle;
		kind: aKind;
		new
]

{ #category : #accessing }
FiRecipe >> defaultStep [

	^ title asSymbol
]

{ #category : #accessing }
FiRecipe >> kind [
	
	^ kind
]

{ #category : #printing }
FiRecipe >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.
	title printOn: aStream.
	aStream nextPut: $).
	
]

{ #category : #accessing }
FiRecipe >> title [
	
	^ title
]
