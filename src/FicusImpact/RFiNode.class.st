Class {
	#name : #RFiNode,
	#superclass : #Object,
	#instVars : [
		'graph',
		'contents',
		'outerEdges',
		'innerEdges'
	],
	#category : #'FicusImpact-Old-Graph'
}

{ #category : #comparing }
RFiNode >> = other [

	^ self class = other class and: [ 
		self contents = other contents ]
]

{ #category : #accessing }
RFiNode >> addInnerEdge: newEdge [
	"Inner edges are owned by the source node, unlike outer edges."

	innerEdges add: newEdge	

]

{ #category : #accessing }
RFiNode >> addOuterEdgeTo: targetNode contents: anObject [
	"Outer edges are owned by self, unlike inner edges."
	
	| newEdge |
	newEdge := 
		RFiEdge new
			graph: graph;
			contents: anObject;
			source: self;
			target: targetNode;
			yourself.

	outerEdges add: newEdge.	
	targetNode addInnerEdge: newEdge.
]

{ #category : #accessing }
RFiNode >> contents [

	^ contents
]

{ #category : #accessing }
RFiNode >> contents: anObject [
	
	contents := anObject
]

{ #category : #accessing }
RFiNode >> graph: aFiGraph [ 
	
	graph := aFiGraph 
]

{ #category : #printing }
RFiNode >> gtInspectorInnerEdgesIn: composite [
	<gtInspectorPresentationOrder: 40> 

	composite table
		title: [ :anObject | anObject innerEdges size asString, ' inner edges' ];
		display: [ self innerEdges ];
		column: 'Source' evaluated: [ :edge | edge source ];
		column: 'Contents' evaluated: [ :edge | edge contents ];
		sorted: [ :x :y | x source asString < y source asString ].
]

{ #category : #printing }
RFiNode >> gtInspectorOuterEdgesIn: composite [
	<gtInspectorPresentationOrder: 40> 

	composite table
		title: [ :anObject | anObject outerEdges size asString, ' outer edges' ];
		display: [ self outerEdges ];
		column: 'Target' evaluated: [ :edge | edge target ];
		column: 'Contents' evaluated: [ :edge | edge contents];
		sorted: [ :x :y | x target asString < y target asString ].
]

{ #category : #comparing }
RFiNode >> hash [

	^ self class hash bitXor: self contents hash
]

{ #category : #initialization }
RFiNode >> initialize [

	super initialize.
	
	outerEdges := OrderedCollection new.
	innerEdges := OrderedCollection new.
]

{ #category : #accessing }
RFiNode >> innerEdges [
	
	^ innerEdges asArray
]

{ #category : #accessing }
RFiNode >> outerEdges [
	
	^ outerEdges asArray
]

{ #category : #printing }
RFiNode >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: contents;
		nextPut: $).
]
