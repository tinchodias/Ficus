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
FiComment >> defaultStep [

	^ ('comment:', target shortDescription, ':', self hash asString) asSymbol
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
