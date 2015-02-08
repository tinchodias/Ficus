"
I represent an abstract point in the history.
"
Class {
	#name : #FiHistoryNode,
	#superclass : #FiFixedObject,
	#instVars : [
		'origin'
	],
	#category : #'FicusStore-Models'
}

{ #category : #accessing }
FiHistoryNode >> defaultStep [

	^ origin printString asSymbol
]

{ #category : #accessing }
FiHistoryNode >> deltas [

	^ self shouldBeImplemented 
]

{ #category : #testing }
FiHistoryNode >> isWorkingCopy [

	^ false
]

{ #category : #accessing }
FiHistoryNode >> origin [

	^ origin
]

{ #category : #printing }
FiHistoryNode >> printOn: aStream [

	super printOn: aStream.

	aStream 
		nextPut: $(;
		nextPutAll: self origin printString;
		nextPut: $).
	
]

{ #category : #accessing }
FiHistoryNode >> priors [

	^ self shouldBeImplemented 
]

{ #category : #accessing }
FiHistoryNode >> snapshot [

	^ self shouldBeImplemented 
]
