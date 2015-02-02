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

	^ ('comment:', target shortDescription, ':', self hash asString) asSymbol
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
