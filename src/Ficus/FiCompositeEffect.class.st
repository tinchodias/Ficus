Class {
	#name : #FiCompositeEffect,
	#superclass : #FiEffect,
	#instVars : [
		'children'
	],
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #converting }
FiCompositeEffect >> asSimpleEffectsAt: aBasePath [

	^ (children values flatCollect: [ :each |
		each asSimpleEffectsAt: aBasePath ]) asFiSet
]

{ #category : #accessing }
FiCompositeEffect >> children [
	
	^ children
]

{ #category : #accessing }
FiCompositeEffect >> edit [
	
	^ self editAll: (children values collect: #edit)
]

{ #category : #accessing }
FiCompositeEffect >> inverse [
	
	^ self editAll: (children values collect: #inverse)
]

{ #category : #printing }
FiCompositeEffect >> printOn: aStream [

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
