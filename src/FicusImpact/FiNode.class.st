Class {
	#name : #FiNode,
	#superclass : #Object,
	#instVars : [
		'graph',
		'contents'
	],
	#category : #'FicusImpact-Graph'
}

{ #category : #comparing }
FiNode >> = other [

	^ self class = other class and: [ 
		self contents = other contents ]
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

{ #category : #comparing }
FiNode >> hash [

	^ self class hash bitXor: self contents hash
]

{ #category : #accessing }
FiNode >> outerEdges [
	
	| result dependenciesByTargetNode |
	result := OrderedCollection new.
	dependenciesByTargetNode := Dictionary new.

	contents ficusAllDependencies do: [ :dependency | 
		dependency targets do: [ :targetEntity |
			| targetNode |
			targetNode := graph nodeFor: targetEntity.

			(dependenciesByTargetNode
				at: targetNode
				ifAbsentPut: [ Set new ])
				add: dependency.
			]].

	dependenciesByTargetNode keysAndValuesDo: [ :targetNode :dependencies |
		result add: (FiEdge new
			graph: graph;
			contents: dependencies;
			source: self;
			target: targetNode;
			yourself) ].
	
	^ result
]

{ #category : #printing }
FiNode >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: contents;
		nextPut: $).
]
