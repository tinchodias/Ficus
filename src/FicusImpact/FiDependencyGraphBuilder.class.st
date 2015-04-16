Class {
	#name : #FiDependencyGraphBuilder,
	#superclass : #Object,
	#instVars : [
		'environment',
		'granularity'
	],
	#category : #'FicusImpact-Old-Graph'
}

{ #category : #examples }
FiDependencyGraphBuilder class >> example1 [

	^ self graphForEnvironment: RFiFragileBaseClassProblemResources5A new ringEnvironment
]

{ #category : #examples }
FiDependencyGraphBuilder class >> example2 [

	^ self graphForEnvironment: RFiFragileBaseClassProblemResources5A new ringEnvironment
]

{ #category : #examples }
FiDependencyGraphBuilder class >> example3 [

	^ self graphForEnvironment: RFiFragileBaseClassProblemResources5A new ringEnvironment
]

{ #category : #examples }
FiDependencyGraphBuilder class >> exampleYrupe [
	"
	[self exampleYrupe] timeToRun
	"

	^ self graphForEnvironment: (YrPharoMigrator example1readTag: '30014') asRFiEnvironment
]

{ #category : #convenience }
FiDependencyGraphBuilder class >> graphForEnvironment: aFiRGEnvironment [

	^ self new
		environment: aFiRGEnvironment;
		granularity: FiAtomicGranularity new;
		newGraph
]

{ #category : #private }
FiDependencyGraphBuilder >> dependenciesByTargetNodeOf: entity graph: graph [
	
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
		 ]
		displayingProgress: [ :entity | 'Calculating dependencies for ', entity printString ] every: 500.
	
	^ graph
]
