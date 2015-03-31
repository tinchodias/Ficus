Class {
	#name : #FiLNode,
	#superclass : #Object,
	#instVars : [
		'graph',
		'contents',
		'outerEdges',
		'innerEdges'
	],
	#category : #'FicusImpact-LGraph'
}

{ #category : #comparing }
FiLNode >> = other [

	^ self class = other class and: [ 
		self contents = other contents ]
]

{ #category : #accessing }
FiLNode >> contents [

	^ contents
]

{ #category : #accessing }
FiLNode >> contents: anObject [
	
	contents := anObject
]

{ #category : #accessing }
FiLNode >> ensurePointTo: targetNode [
	"Outer edges are owned by self, unlike inner edges."
	
	outerEdges add: targetNode.	
	targetNode ensurePointedFrom: self.
]

{ #category : #accessing }
FiLNode >> ensurePointedFrom: aNode [
	"Inner edges are owned by the source node, unlike outer edges."

	innerEdges add: aNode
]

{ #category : #accessing }
FiLNode >> graph: aFiGraph [ 
	
	graph := aFiGraph 
]

{ #category : #comparing }
FiLNode >> hash [

	^ self class hash bitXor: self contents hash
]

{ #category : #initialization }
FiLNode >> initialize [

	super initialize.
	
	outerEdges := Set new: 1.
	innerEdges := Set new: 1.
]

{ #category : #accessing }
FiLNode >> nodesPointedByMe [
	
	^ outerEdges asArray
]

{ #category : #accessing }
FiLNode >> nodesPointingToMe [
	
	^ innerEdges asArray
]

{ #category : #printing }
FiLNode >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: contents;
		nextPut: $).
]
