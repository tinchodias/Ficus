Class {
	#name : #FiEdge,
	#superclass : #Object,
	#instVars : [
		'graph',
		'contents',
		'source',
		'target'
	],
	#category : #'FicusImpact-Graph'
}

{ #category : #accessing }
FiEdge >> contents [
	^ contents
]

{ #category : #accessing }
FiEdge >> contents: aCollection [ 
	
	contents := aCollection
]

{ #category : #accessing }
FiEdge >> graph [
	^ graph
]

{ #category : #accessing }
FiEdge >> graph: aFiGraph [ 
	
	graph := aFiGraph 
]

{ #category : #printing }
FiEdge >> printOn: aStream [

	super printOn: aStream.
	
	contents printElementsOn: aStream.

]

{ #category : #accessing }
FiEdge >> source [
	^ source
]

{ #category : #accessing }
FiEdge >> source: aFiNode [ 
	
	source := aFiNode
]

{ #category : #accessing }
FiEdge >> target [
	^ target
]

{ #category : #accessing }
FiEdge >> target: aFiNode [

	target := aFiNode
]
