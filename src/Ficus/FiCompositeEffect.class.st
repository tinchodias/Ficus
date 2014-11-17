Class {
	#name : #FiCompositeEffect,
	#superclass : #FiEditEffect,
	#instVars : [
		'subEffects'
	],
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #accessing }
FiCompositeEffect >> edit [
	
	^ self editAll: (subEffects values collect: #edit)
]

{ #category : #summary }
FiCompositeEffect >> hierarchicalSummaryFrom: aBasePath [

	^ subEffects values flatCollect: [ :each |
		each hierarchicalSummaryFrom: aBasePath ]
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
