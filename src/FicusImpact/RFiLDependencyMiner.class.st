Class {
	#name : #RFiLDependencyMiner,
	#superclass : #Object,
	#instVars : [
		'environment',
		'dependencyInterpreter',
		'dependencySet',
		'dependencyFilter'
	],
	#category : #'FicusImpact-LDependency'
}

{ #category : #convenience }
RFiLDependencyMiner class >> dependenciesForEnvironment: aRFiEnvironment [

	^ self new
		environment: aRFiEnvironment;
		run;
		dependencySet
]

{ #category : #examples }
RFiLDependencyMiner class >> example1 [
	"
	self example1
	"

	^ self dependenciesForEnvironment: RFiFragileBaseClassProblemResources5A new ringEnvironment
]

{ #category : #examples }
RFiLDependencyMiner class >> exampleYrupe [
	"
	[self exampleYrupe inspect ] timeToRun
	"

	^ self dependenciesForEnvironment: (YrGitPharoExporter example1readTag: '30014') asRFiEnvironment
]

{ #category : #convenience }
RFiLDependencyMiner class >> graphForEnvironment: aRFiEnvironment [

	^ self new
		environment: aRFiEnvironment;
		dependencySet
]

{ #category : #accessing }
RFiLDependencyMiner >> dependencyFilter [

	^ dependencyFilter
]

{ #category : #accessing }
RFiLDependencyMiner >> dependencyFilter: aBinaryBlockClosure [

	dependencyFilter := aBinaryBlockClosure
]

{ #category : #building }
RFiLDependencyMiner >> dependencySet [

	^ dependencySet 
]

{ #category : #accessing }
RFiLDependencyMiner >> entities [

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
RFiLDependencyMiner >> environment [

	^ environment
]

{ #category : #accessing }
RFiLDependencyMiner >> environment: anObject [

	environment := anObject
]

{ #category : #initialization }
RFiLDependencyMiner >> initialize [

	super initialize.
	
	dependencyFilter := [ :sourceEntity :targetEntity | true ]. "approve all dependencies"
	dependencyInterpreter := RFiLDependencyInterpreter new.

]

{ #category : #private }
RFiLDependencyMiner >> newDependencyFrom: sourceEntity to: targetEntity [
	
	^ sourceEntity asMetamodelSpot" asString" -> targetEntity asMetamodelSpot "asString"
	"RFiLDependency from: sourceEntity to: targetEntity"
]

{ #category : #private }
RFiLDependencyMiner >> processEntity: entity [
	
	dependencyInterpreter
		targetsCallback: [ :target |
			(dependencyFilter value: entity value: target) ifTrue: [
				dependencySet add: (self newDependencyFrom: entity to: target)] ];
		entity: entity;
		run.
]

{ #category : #building }
RFiLDependencyMiner >> run [

	dependencySet := OrderedCollection new.

	self entities 
		do: [ :entity | self processEntity: entity ]
		displayingProgress: [ :entity | 'Calculating dependencies for ', entity shortPrintString ] 
		every: 1000. "one per second"

]
