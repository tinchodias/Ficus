Class {
	#name : #FiCompositeEffect,
	#superclass : #FiEditEffect,
	#instVars : [
		'subEffects'
	],
	#category : #'Ficus-Model-Effects'
}

{ #category : #enumerating }
FiCompositeEffect >> leafEffectsDo: aBlockClosure basePath: aPath [ 
	
	^ subEffects valuesDo: [ :value |
		value 
			leafEffectsDo: aBlockClosure 
			basePath: aPath ]
]

{ #category : #accessing }
FiCompositeEffect >> subEffects [
	
	^ subEffects
]

{ #category : #accessing }
FiCompositeEffect >> subEffects: aCollection [ 
	
	subEffects := aCollection
]
