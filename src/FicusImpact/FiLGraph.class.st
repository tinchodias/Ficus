Class {
	#name : #FiLGraph,
	#superclass : #Object,
	#instVars : [
		'nodeByContents'
	],
	#category : #'FicusImpact-LGraph'
}

{ #category : #'optimizing space' }
FiLGraph >> compact [
	
	self nodes do: #compact
]

{ #category : #initialization }
FiLGraph >> initialize [

	super initialize.
	
	nodeByContents := FLLargeIdentityDictionary new.
]

{ #category : #accessing }
FiLGraph >> nodeFor: anObject [ 
	
	^ nodeByContents 
		at: anObject 
		ifAbsentPut: [
			FiLNode new
				contents: anObject;
				yourself ]
]

{ #category : #accessing }
FiLGraph >> nodes [

	^ nodeByContents values
]

{ #category : #printing }
FiLGraph >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: self size;
		nextPut: $).
]

{ #category : #accessing }
FiLGraph >> size [

	^ self nodes size
]
