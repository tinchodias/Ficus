Class {
	#name : #FiCompositeEffect,
	#superclass : #FiEditEffect,
	#instVars : [
		'subEffects'
	],
	#category : #'Ficus-Model-Effects'
}

{ #category : #accessing }
FiCompositeEffect >> subEffects [
	
	^ subEffects
]

{ #category : #accessing }
FiCompositeEffect >> subEffects: aCollection [ 
	
	subEffects := aCollection
]
