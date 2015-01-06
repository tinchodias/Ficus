Class {
	#name : #FiNode,
	#superclass : #Object,
	#instVars : [
		'graph',
		'contents',
		'outerEdges',
		'innerEdges'
	],
	#category : #'FicusImpact-Graph'
}

{ #category : #comparing }
FiNode >> = other [

	^ self class = other class and: [ 
		self contents = other contents ]
]

{ #category : #accessing }
FiNode >> addInnerEdge: newEdge [
	"Inner edges are owned by the source node, unlike outer edges."

	innerEdges add: newEdge	

]

{ #category : #accessing }
FiNode >> addOuterEdgeTo: targetNode contents: anObject [
	"Outer edges are owned by self, unlike inner edges."
	
	| newEdge |
	newEdge := 
		FiEdge new
			graph: graph;
			contents: anObject;
			source: self;
			target: targetNode;
			yourself.

	outerEdges add: newEdge.	
	targetNode addInnerEdge: newEdge.
]

{ #category : #accessing }
FiNode >> contents [

	^ contents
]

{ #category : #accessing }
FiNode >> contents: anObject [
	
	contents := anObject
]

{ #category : #accessing }
FiNode >> graph: aFiGraph [ 
	
	graph := aFiGraph 
]

{ #category : #printing }
FiNode >> gtInspectorInnerEdgesIn: composite [
	<gtInspectorPresentationOrder: 40> 

	composite table
		title: [ :anObject | anObject innerEdges size asString, ' inner edges' ];
		display: [ self innerEdges ];
		column: 'Source' evaluated: [ :edge | edge source ];
		column: 'Contents' evaluated: [ :edge | edge contents ]
]

{ #category : #printing }
FiNode >> gtInspectorOuterEdgesIn: composite [
	<gtInspectorPresentationOrder: 40> 

	composite table
		title: [ :anObject | anObject outerEdges size asString, ' outer edges' ];
		display: [ self outerEdges ];
		column: 'Target' evaluated: [ :edge | edge target ];
		column: 'Contents' evaluated: [ :edge | edge contents]
]

{ #category : #comparing }
FiNode >> hash [

	^ self class hash bitXor: self contents hash
]

{ #category : #initialization }
FiNode >> initialize [

	super initialize.
	
	outerEdges := OrderedCollection new.
	innerEdges := OrderedCollection new.
]

{ #category : #accessing }
FiNode >> innerEdges [
	
	^ innerEdges copy
]

{ #category : #accessing }
FiNode >> outerEdges [
	
	^ outerEdges copy
]

{ #category : #printing }
FiNode >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: contents;
		nextPut: $).
]
