"
I represent a comment to a commit.
"
Class {
	#name : #FiComment,
	#superclass : #FiFixedObject,
	#instVars : [
		'target',
		'score',
		'message'
	],
	#category : #'FicusStore-Comments-Model'
}

{ #category : #testing }
FiComment >> appliesTo: anOrigin [
	
	^ target contains: anOrigin
]

{ #category : #accessing }
FiComment >> defaultStep [

	^ (target shortDescription, '.', self hash printStringHex) asSymbol
]

{ #category : #inspecting }
FiComment >> ficusInspectorIcon [
	
	^ Smalltalk ui icons announcementIcon
]

{ #category : #accessing }
FiComment >> message [
	
	^ message
]

{ #category : #printing }
FiComment >> printOn: aStream [

	super printOn: aStream. 
	
	aStream 
		nextPut: $(;
	 	print: self hash;
		nextPut:$).
]

{ #category : #accessing }
FiComment >> score [
	
	^ score
]

{ #category : #accessing }
FiComment >> target [
	
	^ target
]
