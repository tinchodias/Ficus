Class {
	#name : #FiCompositeOrigin,
	#superclass : #FiHistoryNodeOrigin,
	#instVars : [
		'origins'
	],
	#category : #'FicusStore-History-Models'
}

{ #category : #'as yet unclassified' }
FiCompositeOrigin >> contains: anOrigin [
	
	^ origins values anySatisfy: [ :each | each contains: anOrigin ]
]

{ #category : #'as yet unclassified' }
FiCompositeOrigin >> isComposite [

	^ true
]

{ #category : #'as yet unclassified' }
FiCompositeOrigin >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.
		
	origins values
		do: [ :each | aStream nextPutAll: each printString ]
		separatedBy: [ aStream nextPutAll: '+' ].
		
	aStream nextPut: $).
	
]

{ #category : #'as yet unclassified' }
FiCompositeOrigin >> shortDescription [
	
	^ String streamContents: [ :stream |
		origins values 
			do: [ :each | stream nextPutAll: each shortDescription ] 
			separatedBy: [ stream nextPutAll: '+' ] ]
]

{ #category : #'as yet unclassified' }
FiCompositeOrigin >> someTimeStamp [

	^ (origins values collect: #someTimeStamp) min
]
