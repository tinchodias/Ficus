Class {
	#name : #RFiEdge,
	#superclass : #Object,
	#instVars : [
		'graph',
		'contents',
		'source',
		'target'
	],
	#category : #'FicusImpact-Old-Graph'
}

{ #category : #accessing }
RFiEdge >> contents [
	^ contents
]

{ #category : #accessing }
RFiEdge >> contents: aCollection [ 
	
	contents := aCollection
]

{ #category : #accessing }
RFiEdge >> graph [
	^ graph
]

{ #category : #accessing }
RFiEdge >> graph: aFiGraph [ 
	
	graph := aFiGraph 
]

{ #category : #printing }
RFiEdge >> printOn: aStream [

	super printOn: aStream.
	
	contents printElementsOn: aStream.

]

{ #category : #accessing }
RFiEdge >> source [
	^ source
]

{ #category : #accessing }
RFiEdge >> source: aFiNode [ 
	
	source := aFiNode
]

{ #category : #accessing }
RFiEdge >> target [
	^ target
]

{ #category : #accessing }
RFiEdge >> target: aFiNode [

	target := aFiNode
]
