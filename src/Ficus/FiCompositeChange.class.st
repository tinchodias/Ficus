Class {
	#name : #FiCompositeChange,
	#superclass : #FiChange,
	#instVars : [
		'children'
	],
	#category : #'Ficus-Model-Core-Changes'
}

{ #category : #converting }
FiCompositeChange >> asSimpleChangesAt: aBasePath [

	^ (children values flatCollect: [ :each |
		each asSimpleChangesAt: aBasePath ]) asFiSet
]

{ #category : #accessing }
FiCompositeChange >> children [
	
	^ children
]

{ #category : #accessing }
FiCompositeChange >> edit [
	
	^ self editAll: (children values collect: #edit)
]

{ #category : #accessing }
FiCompositeChange >> inverse [
	
	^ self editAll: (children values collect: #inverse)
]

{ #category : #printing }
FiCompositeChange >> printOn: aStream [

	| delimitingBlock |
	super printOn: aStream.

	aStream nextPut: $(.
		
	delimitingBlock := [ aStream cr; tab ].
	delimitingBlock value.

	children values
		do: [ :each | aStream print: each ]
		separatedBy: delimitingBlock.
		
	aStream nextPut: $).
]
