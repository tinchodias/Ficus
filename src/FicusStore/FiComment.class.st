Class {
	#name : #FiComment,
	#superclass : #FiFixedObject,
	#instVars : [
		'target',
		'contents',
		'path'
	],
	#category : #'FicusStore-Models'
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
FiComment >> defaultStep [

	^ ('comment:', target shortDescription, ':', self hash asString) asSymbol
]

{ #category : #accessing }
FiComment >> path [
	
	^ path
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
FiComment >> target [
	
	^ target
]
