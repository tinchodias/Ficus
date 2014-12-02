Class {
	#name : #FiNoEffect,
	#superclass : #FiEffect,
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #converting }
FiNoEffect >> asSimpleEffectAt: aBasePath [
	
	^ #()
]

{ #category : #accessing }
FiNoEffect >> edit [

	^ FiNoEdit new
]

{ #category : #accessing }
FiNoEffect >> inverse [

	^ self edit
]

{ #category : #testing }
FiNoEffect >> isNoEffect [

	^ true
]

{ #category : #enumerating }
FiNoEffect >> leafEffectsDo: aBlockClosure basePath: aPath [ 
	
	^ self
]
