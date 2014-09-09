Class {
	#name : #FiCompositeOrigin,
	#superclass : #FiHistoryNodeOrigin,
	#instVars : [
		'origins'
	],
	#category : #'FicusStore-History-Models'
}

{ #category : #enumerating }
FiCompositeOrigin >> anySatisfy: aBlock [
	
	^ origins values anySatisfy: aBlock
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

{ #category : #accessing }
FiCompositeOrigin >> someTimeStamp [

	^ (origins values collect: #someTimeStamp) min
]
