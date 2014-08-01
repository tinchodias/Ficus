Class {
	#name : #FiNoEffect,
	#superclass : #FiEditEffect,
	#category : #'Ficus-Model-Effects'
}

{ #category : #accessing }
FiNoEffect >> edit [

	^ FiNoEdit new
]

{ #category : #'as yet unclassified' }
FiNoEffect >> hierarchicalSummary [
	
	^ #()
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
