Class {
	#name : #RFiLDependencyGraphBuilder,
	#superclass : #Object,
	#instVars : [
		'environment',
		'dependencyInterpreter'
	],
	#category : #'FicusImpact-LGraph'
}

{ #category : #examples }
RFiLDependencyGraphBuilder class >> example1 [

	^ self graphForEnvironment: RFiFragileBaseClassProblemResources5A new ringEnvironment
]

{ #category : #examples }
RFiLDependencyGraphBuilder class >> exampleYrupe [
	"
	[self exampleYrupe] timeToRun
	"

	^ self graphForEnvironment: (YrGitPharoExporter example1readTag: '30014') asRFiEnvironment
]

{ #category : #convenience }
RFiLDependencyGraphBuilder class >> graphForEnvironment: aRFiEnvironment [

	^ self new
		environment: aRFiEnvironment;
		newGraph
]

{ #category : #building }
RFiLDependencyGraphBuilder >> entities [

	self flag: #todo.

	^ Array streamContents: [ :stream |
		environment allClassesAndTraitsDo: [ :class |
			stream 
				nextPut: class;
				"nextPut: class classSide; TODO: collector class-traits of the traitComposition" 
				nextPutAll: class methods;
				nextPutAll: class classSide methods ]]
]

{ #category : #accessing }
RFiLDependencyGraphBuilder >> environment [
	^ environment
]

{ #category : #accessing }
RFiLDependencyGraphBuilder >> environment: anObject [
	environment := anObject
]

{ #category : #initialization }
RFiLDependencyGraphBuilder >> initialize [

	super initialize.
	
	dependencyInterpreter := RFiLDependencyInterpreter new.
]

{ #category : #building }
RFiLDependencyGraphBuilder >> newGraph [

	| graph |
	graph := RFiLGraph new.

	self entities 
		do: [ :entity | self processEntity: entity graph: graph ]
		displayingProgress: [ :entity | 'Calculating dependencies for ', entity shortPrintString ] 
		every: 1000. "one per second"
	
	^ graph
]

{ #category : #private }
RFiLDependencyGraphBuilder >> processEntity: entity graph: graph [
	
	| node |
	node := graph nodeFor: entity.

	dependencyInterpreter
		targetsCallback: [ :target |
			node ensurePointTo: (graph nodeFor: target) ];
		entity: entity;
		run.
]
