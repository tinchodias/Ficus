Class {
	#name : #FiNoEffect,
	#superclass : #FiEditEffect,
	#category : #'Ficus-Model-Effects'
}

{ #category : #accessing }
FiNoEffect >> edit [

	^ FiNoEdit new
]

{ #category : #accessing }
FiNoEffect >> inverse [

	^ self edit
]

{ #category : #enumerating }
FiNoEffect >> leafEffectsDo: aBlockClosure basePath: aPath [ 
	
	^ self
]
