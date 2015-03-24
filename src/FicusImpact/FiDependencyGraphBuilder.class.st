Class {
	#name : #FiDependencyGraphBuilder,
	#superclass : #Object,
	#instVars : [
		'environment',
		'granularity'
	],
	#category : #'FicusImpact-Graph'
}

{ #category : #examples }
FiDependencyGraphBuilder class >> example1 [

	^ (self new
		environment: FiFragileBaseClassProblemResourcesA new ficusRGEnvironment;
		granularity: FiPackageGranularity new;
		newGraph) inspect
]

{ #category : #examples }
FiDependencyGraphBuilder class >> example2 [

	^ (self new
		environment: FiFragileBaseClassProblemResourcesA new ficusRGEnvironment;
		granularity: FiClassGranularity new;
		newGraph) inspect
]

{ #category : #examples }
FiDependencyGraphBuilder class >> example3 [

	^ (self new
		environment: FiFragileBaseClassProblemResourcesA new ficusRGEnvironment;
		granularity: FiAtomicGranularity new;
		newGraph) inspect
]

{ #category : #private }
FiDependencyGraphBuilder >> dependenciesByTargetNodeOf: entity graph: graph [
	
	| dependenciesByTargetNode |
	dependenciesByTargetNode := Dictionary new.

	entity ficusAllDependencies do: [ :dependency | 
		dependency targets do: [ :dependencyTarget |
			(dependenciesByTargetNode
				at: (graph nodeFor: (granularity entityFor: dependencyTarget))
				ifAbsentPut: [ Set new ])
				add: dependency.
			]].

	^ dependenciesByTargetNode
]

{ #category : #accessing }
FiDependencyGraphBuilder >> environment [
	^ environment
]

{ #category : #accessing }
FiDependencyGraphBuilder >> environment: anObject [
	environment := anObject
]

{ #category : #accessing }
FiDependencyGraphBuilder >> granularity [
	^ granularity
]

{ #category : #accessing }
FiDependencyGraphBuilder >> granularity: anObject [
	granularity := anObject
]

{ #category : #building }
FiDependencyGraphBuilder >> newGraph [

	| graph entities |
	graph := FiGraph new.
	graph environment: environment.

	entities := granularity allEntitiesFor: environment.
	
	entities do: [ :entity |
		| node |
		node := graph nodeFor: entity.
	
		(self dependenciesByTargetNodeOf: entity graph: graph) 
			keysAndValuesDo: [ :targetNode :dependencies |
				node addOuterEdgeTo: targetNode contents: dependencies ].
		 ].
	
	^ graph
]
