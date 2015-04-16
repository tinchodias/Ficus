Class {
	#name : #FiLDependencyGraphBuilder,
	#superclass : #Object,
	#instVars : [
		'environment',
		'dependencyInterpreter'
	],
	#category : #'FicusImpact-LGraph'
}

{ #category : #examples }
FiLDependencyGraphBuilder class >> example1 [

	^ self graphForEnvironment: RFiFragileBaseClassProblemResources5A new ringEnvironment
]

{ #category : #examples }
FiLDependencyGraphBuilder class >> exampleYrupe [
	"
	[self exampleYrupe] timeToRun
	"

	^ self graphForEnvironment: (YrPharoMigrator example1readTag: '30014') asRFiEnvironment
]

{ #category : #convenience }
FiLDependencyGraphBuilder class >> graphForEnvironment: aFiRGEnvironment [

	^ self new
		environment: aFiRGEnvironment;
		newGraph
]

{ #category : #building }
FiLDependencyGraphBuilder >> entities [

	^ Array streamContents: [ :stream |
		environment allClassesAndTraitsDo: [ :class |
			stream 
				nextPutAll: class methods;
				nextPutAll: class classSide methods ]]
]

{ #category : #accessing }
FiLDependencyGraphBuilder >> environment [
	^ environment
]

{ #category : #accessing }
FiLDependencyGraphBuilder >> environment: anObject [
	environment := anObject
]

{ #category : #initialization }
FiLDependencyGraphBuilder >> initialize [

	super initialize.
	
	dependencyInterpreter := FiLDependencyInterpreter new.
]

{ #category : #building }
FiLDependencyGraphBuilder >> newGraph [

	| graph |
	graph := FiLGraph new.

	self entities 
		do: [ :entity | self processEntity: entity graph: graph ]
		displayingProgress: [ :entity | 'Calculating dependencies for ', entity shortPrintString ] every: 800.
	
	^ graph
]

{ #category : #private }
FiLDependencyGraphBuilder >> processEntity: entity graph: graph [
	
	| node |
	node := graph nodeFor: entity.

	dependencyInterpreter
		targetsCallback: [ :target |
			node ensurePointTo: (graph nodeFor: target) ];
		entity: entity;
		run.
]
