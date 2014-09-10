Class {
	#name : #FiComment,
	#superclass : #FiFixedObject,
	#instVars : [
		'target',
		'contents'
	],
	#category : #'FicusStore-History-Models'
}

{ #category : #testing }
FiComment >> appliesTo: anOrigin [
	
	^ target contains: anOrigin
]

{ #category : #accessing }
FiComment >> contents [
	
	^ contents
]

{ #category : #accessing }
FiComment >> target [
	
	^ target
]
