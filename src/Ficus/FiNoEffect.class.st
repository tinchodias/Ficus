Class {
	#name : #FiNoEffect,
	#superclass : #FiEditEffect,
	#category : #'Ficus-Model-Effects'
}

{ #category : #accessing }
FiNoEffect >> inverse [

	^ FiNoEdit new
]

{ #category : #enumerating }
FiNoEffect >> leafEffectsDo: aBlockClosure basePath: aPath [ 
	
	^ self
]
