Class {
	#name : #RFiGraph,
	#superclass : #Object,
	#instVars : [
		'environment',
		'nodeByContents'
	],
	#category : #'FicusImpact-Old-Graph'
}

{ #category : #accessing }
RFiGraph >> edges [

	^ self nodes flatCollect: #outerEdges
]

{ #category : #accessing }
RFiGraph >> environment: aFiRGEnvironment [ 
	
	environment := aFiRGEnvironment 
]

{ #category : #printing }
RFiGraph >> gtInspectorNodesIn: composite [
	<gtInspectorPresentationOrder: 40> 

	composite list
		title: [ :anObject | anObject nodes size asString, ' nodes' ];
		display: [ self nodes ];
		sorted: [ :x :y | x asString < y asString ].
]

{ #category : #initialization }
RFiGraph >> initialize [

	super initialize.
	
	nodeByContents := Dictionary new.
]

{ #category : #accessing }
RFiGraph >> nodeFor: anObject [ 
	
	^ nodeByContents 
		at: anObject 
		ifAbsentPut: [
			RFiNode new
				graph: self;
				contents: anObject;
				yourself ]
]

{ #category : #accessing }
RFiGraph >> nodes [

	^ nodeByContents values
]

{ #category : #printing }
RFiGraph >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: self nodes size;
		nextPut: $).
]
