Class {
	#name : #FiLGraph,
	#superclass : #Object,
	#instVars : [
		'environment',
		'nodeByContents'
	],
	#category : #'FicusImpact-LGraph'
}

{ #category : #accessing }
FiLGraph >> environment: aFiRGEnvironment [ 
	
	environment := aFiRGEnvironment 
]

{ #category : #initialization }
FiLGraph >> initialize [

	super initialize.
	
	nodeByContents := Dictionary new.
]

{ #category : #accessing }
FiLGraph >> nodeFor: anObject [ 
	
	^ nodeByContents 
		at: anObject 
		ifAbsentPut: [
			FiLNode new
				graph: self;
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
