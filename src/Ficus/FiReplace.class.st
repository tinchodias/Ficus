Class {
	#name : #FiReplace,
	#superclass : #FiEditEffect,
	#instVars : [
		'oldValue'
	],
	#category : #'Ficus-Model-Effects'
}

{ #category : #enumerating }
FiReplace >> leafEffectsDo: aBlockClosure basePath: aPath [ 
	
	^ aBlockClosure 
		value: self 
		value: aPath
]

{ #category : #accessing }
FiReplace >> oldValue [

	^ oldValue
]
