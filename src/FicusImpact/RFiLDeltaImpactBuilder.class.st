Class {
	#name : #RFiLDeltaImpactBuilder,
	#superclass : #Object,
	#instVars : [
		'origin',
		'destination',
		'impactInOrigin',
		'deltaSimpleChanges'
	],
	#category : #'FicusImpact-LDependency'
}

{ #category : #examples }
RFiLDeltaImpactBuilder class >> example1 [
	"
	self example1
	"

	^ self exampleFragileBaseProblemWithBaseEnvironment: RFiBaseResources new ringEnvironment
]

{ #category : #examples }
RFiLDeltaImpactBuilder class >> exampleFragileBaseProblemWithBaseEnvironment: baseEnvironment [

	| builder envA envA2 envB delta packageA packageA2 packageB deltaImpacts  |
	packageA := RFiFragileBaseClassProblemResources3 new packageLoggers.
	packageA2 := RFiFragileBaseClassProblemResources4A new packageLoggers.
	packageB := RFiFragileBaseClassProblemResources4B new packageLoggers.
	
	envA := (baseEnvironment ficusPackages copyWith: packageA) asRFiEnvironment.
	envA2:= (baseEnvironment ficusPackages copyWith: packageA2) asRFiEnvironment.
	envB := (baseEnvironment ficusPackages copyWith: packageB) asRFiEnvironment.
	delta := (envA2 ficusEnvironment changeFrom: envA ficusEnvironment) asSimpleChanges asArray.

	builder := RFiLDeltaImpactBuilder new.
	builder origin: envA.
	builder destination: envB.
	builder delta: delta.
	
	FileStream stdout 
		print: [deltaImpacts := builder deltaImpacts] timeToRun.
	
	^ deltaImpacts

]

{ #category : #examples }
RFiLDeltaImpactBuilder class >> exampleSlice [
	"
	https://pharo.fogbugz.com/f/cases/15764/Clean-up-discouraged-uses-of-SourceFiles-and-friends-1
	=> integrated in Pharo 50112.
	Would it have the same impact in Pharo 40?
	
	self exampleSlice inspect.
	"

	| slicePackages  builder envA envA2 envB delta deltaImpacts |
	slicePackages := FiSliceWriter example15764.

	envA := (YrGitPharoExporter example1readTag: '50111') asRFiEnvironment.
	envA2:= (envA ficusPackages copyWithAll: slicePackages) asRFiEnvironment.
	delta := (envA2 ficusEnvironment changeFrom: envA ficusEnvironment) asSimpleChanges asArray.

	"FiChangeInspector inspect: (envA2 ficusEnvironment changeFrom: envA ficusEnvironment)."
	
	envB := (YrGitPharoExporter example1readTag: '40614') asRFiEnvironment.

	builder := RFiLDeltaImpactBuilder new.
	builder origin: envA.
	builder destination: envB.
	builder delta: delta.
	
	FileStream stdout 
		print: [deltaImpacts := builder deltaImpacts] timeToRun.
	
	^ deltaImpacts

]

{ #category : #examples }
RFiLDeltaImpactBuilder class >> exampleYrupe [
	"
	self exampleYrupe
	"

	self exampleFragileBaseProblemWithBaseEnvironment: (YrGitPharoExporter example1readTag: '30014') asRFiEnvironment
]

{ #category : #API }
RFiLDeltaImpactBuilder >> delta: aFiSimpleChange [

	deltaSimpleChanges := aFiSimpleChange
]

{ #category : #private }
RFiLDeltaImpactBuilder >> deltaEdit [

	self flag: #todo. "ARGH... this seems to be the most precise way to get an edit from a delta"
	^ origin ficusEnvironment editFromSimpleChanges: deltaSimpleChanges
]

{ #category : #API }
RFiLDeltaImpactBuilder >> deltaImpacts [

	| impactInDestination impactExtra impactMissing |
	impactInOrigin := self impactOn: origin.
	impactInDestination := self impactOn: destination.
	
	impactExtra := impactInOrigin first copyWithoutAll: impactInDestination first.
	impactMissing := impactInOrigin second copyWithoutAll: impactInDestination second.
	
	^ { impactExtra. impactMissing }
]

{ #category : #private }
RFiLDeltaImpactBuilder >> dependenciesForEnvironment: anEnvironment [

	^ RFiLDependencyMiner new
		environment: anEnvironment;
		dependencyFilter: [ :source :target |
			(self subjectIncludes: source) or: [ self subjectIncludes: target ] ];
		run;
		dependencySet.
]

{ #category : #API }
RFiLDeltaImpactBuilder >> destination: aRFiEnvironment [ 

	destination := aRFiEnvironment
]

{ #category : #private }
RFiLDeltaImpactBuilder >> impactOn: anEnvironment [ 

	| anEnvironmentPlusDelta dependenciesBefore dependenciesAfter dependenciesIntroduced dependenciesRemoved |
	anEnvironmentPlusDelta := (anEnvironment ficusEnvironment resultOf: self deltaEdit) asRFiEnvironment.
	
	dependenciesBefore := self dependenciesForEnvironment: anEnvironment.
	dependenciesAfter := self dependenciesForEnvironment: anEnvironmentPlusDelta.
	
	dependenciesIntroduced := dependenciesAfter copyWithoutAll: dependenciesBefore.
	dependenciesRemoved := dependenciesBefore copyWithoutAll: dependenciesAfter.
	
	^ { dependenciesIntroduced. dependenciesRemoved }
]

{ #category : #API }
RFiLDeltaImpactBuilder >> origin: aRFiEnvironment [ 
	
	origin := aRFiEnvironment
]

{ #category : #private }
RFiLDeltaImpactBuilder >> subjectIncludes: anEntity [
	
	^ deltaSimpleChanges anySatisfy: [ :simpleChange | 
		simpleChange hasChangeAt: (anEntity asMetamodelSpot asPathOn: origin ficusEnvironment) ]
]
