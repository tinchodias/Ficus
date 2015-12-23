Class {
	#name : #RFiDependencyGraphBuilder,
	#superclass : #Object,
	#instVars : [
		'environment',
		'granularity'
	],
	#category : #'FicusImpact-Old-Graph'
}

{ #category : #examples }
RFiDependencyGraphBuilder class >> example1 [

	^ self graphForEnvironment: RFiFragileBaseClassProblemResources5A new ringEnvironment
]

{ #category : #examples }
RFiDependencyGraphBuilder class >> example2 [

	^ self graphForEnvironment: RFiFragileBaseClassProblemResources5A new ringEnvironment
]

{ #category : #examples }
RFiDependencyGraphBuilder class >> example3 [

	^ self graphForEnvironment: RFiFragileBaseClassProblemResources5A new ringEnvironment
]

{ #category : #examples }
RFiDependencyGraphBuilder class >> exampleYrupe [
	"
	[self exampleYrupe] timeToRun
	"

	^ self graphForEnvironment: (YrGitPharoExporter example1readTag: '30014') asRFiEnvironment
]

{ #category : #convenience }
RFiDependencyGraphBuilder class >> graphForEnvironment: aRFiEnvironment [

	^ self new
		environment: aRFiEnvironment;
		granularity: RFiAtomicGranularity new;
		newGraph
]

{ #category : #private }
RFiDependencyGraphBuilder >> dependenciesByTargetNodeOf: entity graph: graph [
	
	| dependenciesByTargetNode |
	dependenciesByTargetNode := Dictionary new.

	entity ficusAllDependencies do: [ :dependency | 
		dependency targets do: [ :dependencyTarget |
			(dependenciesByTargetNode
				at: (graph nodeFor: (granularity entityFor: dependencyTarget))
				ifAbsentPut: [ OrderedCollection new ])
				add: dependency.
			]].

	^ dependenciesByTargetNode
]

{ #category : #accessing }
RFiDependencyGraphBuilder >> environment [
	^ environment
]

{ #category : #accessing }
RFiDependencyGraphBuilder >> environment: anObject [
	environment := anObject
]

{ #category : #accessing }
RFiDependencyGraphBuilder >> granularity [
	^ granularity
]

{ #category : #accessing }
RFiDependencyGraphBuilder >> granularity: anObject [
	granularity := anObject
]

{ #category : #building }
RFiDependencyGraphBuilder >> newGraph [

	| graph entities |
	graph := RFiGraph new.
	graph environment: environment.

	entities := granularity allEntitiesFor: environment.
	
	entities do: [ :entity |
		| node |
		node := graph nodeFor: entity.
	
		(self dependenciesByTargetNodeOf: entity graph: graph) 
			keysAndValuesDo: [ :targetNode :dependencies |
				node addOuterEdgeTo: targetNode contents: dependencies ].
		 ]
		displayingProgress: [ :entity | 'Calculating dependencies for ', entity printString ] every: 500.
	
	^ graph
]
