Class {
	#name : #FiCompositeEffect,
	#superclass : #FiEffect,
	#instVars : [
		'subEffects'
	],
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #converting }
FiCompositeEffect >> asSimpleEffectAt: aBasePath [

	^ subEffects values flatCollect: [ :each |
		each asSimpleEffectAt: aBasePath ]
]

{ #category : #accessing }
FiCompositeEffect >> edit [
	
	^ self editAll: (subEffects values collect: #edit)
]

{ #category : #accessing }
FiCompositeEffect >> inverse [
	
	^ self editAll: (subEffects values collect: #inverse)
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
