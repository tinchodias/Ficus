Class {
	#name : #FiCompositeEffect,
	#superclass : #FiEditEffect,
	#instVars : [
		'subEffects'
	],
	#category : #'Ficus-Model-Effects'
}

{ #category : #accessing }
FiCompositeEffect >> edit [
	
	^ self edits: (subEffects values collect: #edit)
]

{ #category : #accessing }
FiCompositeEffect >> inverse [
	
	^ self edits: (subEffects values collect: #inverse)
]

{ #category : #enumerating }
FiCompositeEffect >> leafEffectsDo: aBlockClosure basePath: aPath [ 
	
	^ subEffects valuesDo: [ :value |
		value 
			leafEffectsDo: aBlockClosure 
			basePath: aPath ]
]

{ #category : #printing }
FiCompositeEffect >> printOn: aStream [

	| delimitingBlock |
	super printOn: aStream.

	aStream nextPut: $(.
		
	delimitingBlock := [ aStream cr; tab ].
	delimitingBlock value.

	subEffects values
		do: [ :each | aStream print: each ]
		separatedBy: delimitingBlock.
		
	aStream nextPut: $).
]

{ #category : #accessing }
FiCompositeEffect >> subEffects [
	
	^ subEffects
]
