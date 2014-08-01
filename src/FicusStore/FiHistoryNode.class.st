Class {
	#name : #FiHistoryNode,
	#superclass : #FiFixedObject,
	#instVars : [
		'origin'
	],
	#category : #'FicusStore-HistoryNodes'
}

{ #category : #accessing }
FiHistoryNode >> origin [

	^ origin
]

{ #category : #accessing }
FiHistoryNode >> patches [

	^ self shouldBeImplemented 
]

{ #category : #accessing }
FiHistoryNode >> priors [

	^ self shouldBeImplemented 
]

{ #category : #accessing }
FiHistoryNode >> snapshot [

	^ self shouldBeImplemented 
]
