Class {
	#name : #FiSetUpdateEffect,
	#superclass : #FiSetEffect,
	#instVars : [
		'oldValue',
		'subEffect'
	],
	#category : #'Ficus-Model-Effects'
}

{ #category : #accessing }
FiSetUpdateEffect >> edit [
	
	^ self include: theValue
]

{ #category : #accessing }
FiSetUpdateEffect >> inverse [

	^ self include: oldValue
]

{ #category : #enumerating }
FiSetUpdateEffect >> leafEffectsDo: aBlockClosure basePath: aPath [ 

	^ subEffect 
		leafEffectsDo: aBlockClosure 
		basePath: aPath / theValue defaultStep

]

{ #category : #accessing }
FiSetUpdateEffect >> oldValue [

	^ oldValue
]

{ #category : #accessing }
FiSetUpdateEffect >> subEffect [

	^ subEffect
]
