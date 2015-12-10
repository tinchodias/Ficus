Class {
	#name : #FiGraph,
	#superclass : #Object,
	#instVars : [
		'environment',
		'nodeByContents'
	],
	#category : #'FicusImpact-Graph'
}

{ #category : #accessing }
FiGraph >> edges [

	^ self nodes flatCollect: #outerEdges
]

{ #category : #accessing }
FiGraph >> environment: aFiRGEnvironment [ 
	
	environment := aFiRGEnvironment 
]

{ #category : #printing }
FiGraph >> gtInspectorNodesIn: composite [
	<gtInspectorPresentationOrder: 40> 

	composite list
		title: [ :anObject | anObject nodes size asString, ' nodes' ];
		display: [ self nodes ];
		sorted: [ :x :y | x asString < y asString ].
]

{ #category : #initialization }
FiGraph >> initialize [

	super initialize.
	
	nodeByContents := Dictionary new.
]

{ #category : #accessing }
FiGraph >> nodeFor: anObject [ 
	
	^ nodeByContents 
		at: anObject 
		ifAbsentPut: [
			FiNode new
				graph: self;
				contents: anObject;
				yourself ]
]

{ #category : #accessing }
FiGraph >> nodes [

	^ nodeByContents values
]

{ #category : #printing }
FiGraph >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: self nodes size;
		nextPut: $).
]
