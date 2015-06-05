Class {
	#name : #FiTag,
	#superclass : #FiFixedObject,
	#instVars : [
		'origin',
		'priorDefaultStep',
		'path',
		'contents'
	],
	#category : #'FicusStore-Tags-Model'
}

{ #category : #testing }
FiTag >> appliesToOrigin: anOrigin prior: aPriorDefaultStep path: aPath [

	^ (self origin contains: anOrigin) and: [ 
		aPriorDefaultStep = priorDefaultStep and: [ 
		aPath = path ] ]
]

{ #category : #accessing }
FiTag >> contents [
	
	^ contents
]

{ #category : #accessing }
FiTag >> origin [
	
	^ origin
]

{ #category : #accessing }
FiTag >> path [
	
	^ path
]

{ #category : #accessing }
FiTag >> priorDefaultStep [
	
	^ priorDefaultStep
]
