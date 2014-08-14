Class {
	#name : #FiComment,
	#superclass : #FiFixedObject,
	#instVars : [
		'target',
		'contents'
	],
	#category : #'FicusStore-HistoryNodes'
}

{ #category : #testing }
FiComment >> appliesTo: anOrigin [
	
	^ target = anOrigin
]

{ #category : #accessing }
FiComment >> contents [
	
	^ contents
]

{ #category : #accessing }
FiComment >> target [
	
	^ target
]
