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

	^ self graphForEnvironment: (YrPharoMigrator example1readTag: '30014') asRFiEnvironment
]

{ #category : #convenience }
RFiLDependencyGraphBuilder class >> graphForEnvironment: aFiRGEnvironment [

	^ self new
		environment: aFiRGEnvironment;
		newGraph
]

{ #category : #building }
RFiLDependencyGraphBuilder >> entities [

	^ Array streamContents: [ :stream |
		environment allClassesAndTraitsDo: [ :class |
			stream 
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
		displayingProgress: [ :entity | 'Calculating dependencies for ', entity shortPrintString ] every: 800.
	
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
