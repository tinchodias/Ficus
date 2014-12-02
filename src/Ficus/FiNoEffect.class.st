Class {
	#name : #FiNoEffect,
	#superclass : #FiEffect,
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #converting }
FiNoEffect >> asSimpleEffectsAt: aBasePath [
	
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
