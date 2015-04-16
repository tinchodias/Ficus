Class {
	#name : #RFiLGraph,
	#superclass : #Object,
	#instVars : [
		'nodeByContents'
	],
	#category : #'FicusImpact-LGraph'
}

{ #category : #'optimizing space' }
RFiLGraph >> compact [
	
	self nodes do: #compact
]

{ #category : #initialization }
RFiLGraph >> initialize [

	super initialize.
	
	nodeByContents := FLLargeIdentityDictionary new.
]

{ #category : #accessing }
RFiLGraph >> nodeFor: anObject [ 
	
	^ nodeByContents 
		at: anObject 
		ifAbsentPut: [
			RFiLNode new
				contents: anObject;
				yourself ]
]

{ #category : #accessing }
RFiLGraph >> nodes [

	^ nodeByContents values
]

{ #category : #printing }
RFiLGraph >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: self size;
		nextPut: $).
]

{ #category : #accessing }
RFiLGraph >> size [

	^ self nodes size
]
