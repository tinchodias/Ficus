Class {
	#name : #FiLDependencyGraphBuilder,
	#superclass : #Object,
	#instVars : [
		'environment',
		'granularity'
	],
	#category : #'FicusImpact-LGraph'
}

{ #category : #examples }
FiLDependencyGraphBuilder class >> example1 [

	^ self graphForEnvironment: FiFragileBaseClassProblemResources5A new ficusRGEnvironment
]

{ #category : #examples }
FiLDependencyGraphBuilder class >> example2 [

	^ self graphForEnvironment: FiFragileBaseClassProblemResources5A new ficusRGEnvironment
]

{ #category : #examples }
FiLDependencyGraphBuilder class >> example3 [

	^ self graphForEnvironment: FiFragileBaseClassProblemResources5A new ficusRGEnvironment
]

{ #category : #examples }
FiLDependencyGraphBuilder class >> exampleYrupe [
	"
	[self exampleYrupe] timeToRun
	"

	^ self graphForEnvironment: (YrPharoMigrator example1readTag: '30014') asFiRGEnvironment
]

{ #category : #convenience }
FiLDependencyGraphBuilder class >> graphForEnvironment: aFiRGEnvironment [

	^ self new
		environment: aFiRGEnvironment;
		granularity: FiAtomicGranularity new;
		newGraph
]

{ #category : #accessing }
FiLDependencyGraphBuilder >> environment [
	^ environment
]

{ #category : #accessing }
FiLDependencyGraphBuilder >> environment: anObject [
	environment := anObject
]

{ #category : #accessing }
FiLDependencyGraphBuilder >> granularity [
	^ granularity
]

{ #category : #accessing }
FiLDependencyGraphBuilder >> granularity: anObject [
	granularity := anObject
]

{ #category : #building }
FiLDependencyGraphBuilder >> newGraph [

	| graph entities |
	graph := FiLGraph new.
	graph environment: environment.

	entities := granularity allEntitiesFor: environment.
	
	entities 
		do: [ :entity | self processEntity: entity graph: graph ]
		inParallel: 4.
	
	^ graph
]

{ #category : #private }
FiLDependencyGraphBuilder >> processEntity: entity graph: graph [
	
	| node |
	node := graph nodeFor: entity.

	entity ficusAllDependencies do: [ :dependency | 
		dependency targets do: [ :dependencyTarget |
			| targetNode |
			targetNode := graph nodeFor: (granularity entityFor: dependencyTarget).
			
			node ensurePointTo: targetNode.
		]].

]
