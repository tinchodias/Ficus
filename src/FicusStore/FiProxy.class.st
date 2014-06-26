"
I represent a proxy of another shot. My tag can be used for finding such proxied shot.
"
Class {
	#name : #FiProxy,
	#superclass : #FiShot,
	#category : #'FicusStore-Model'
}

{ #category : #testing }
FiProxy >> isProxy [

	^ true
]

{ #category : #enumerating }
FiProxy >> stepsAndValuesDo: aBlockClosure [ 

	^ self "I don't have steps or values because I'm a proxy"
]
