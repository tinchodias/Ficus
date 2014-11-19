Class {
	#name : #FiCompositeOrigin,
	#superclass : #FiHistoryNodeOrigin,
	#instVars : [
		'origins'
	],
	#category : #'FicusStore-Models'
}

{ #category : #'instance creation' }
FiCompositeOrigin class >> withOrigins: aCollectionOfOrigins [

	^ self builder 
		origins: aCollectionOfOrigins asFiSet;
		new
]

{ #category : #comparing }
FiCompositeOrigin >> contains: anOrigin [
	
	^ origins values anySatisfy: [ :each | each contains: anOrigin ]
]

{ #category : #testing }
FiCompositeOrigin >> isComposite [

	^ true
]

{ #category : #printing }
FiCompositeOrigin >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.
		
	origins values
		do: [ :each | aStream nextPutAll: each printString ]
		separatedBy: [ aStream nextPutAll: '+' ].
		
	aStream nextPut: $).
	
]

{ #category : #printing }
FiCompositeOrigin >> shortDescription [
	
	^ String streamContents: [ :stream |
		origins values 
			do: [ :each | stream nextPutAll: each shortDescription ] 
			separatedBy: [ stream nextPutAll: '+' ] ]
]
