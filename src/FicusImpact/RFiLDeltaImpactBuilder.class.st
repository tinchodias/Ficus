Class {
	#name : #RFiLDeltaImpactBuilder,
	#superclass : #Object,
	#instVars : [
		'origin',
		'destination',
		'delta',
		'impactInOrigin',
		'deltaSimpleEffectsArray'
	],
	#category : #'FicusImpact-LDependency'
}

{ #category : #examples }
RFiLDeltaImpactBuilder class >> example1 [
	"
	self example1
	"

	self exampleFragileBaseProblemWithBaseEnvironment: RFiBaseResources new ringEnvironment
]

{ #category : #examples }
RFiLDeltaImpactBuilder class >> exampleFragileBaseProblemWithBaseEnvironment: baseEnvironment [

	| builder envA envA2 envB delta packageA packageA2 packageB deltaImpacts time |
	packageA := RFiFragileBaseClassProblemResources3 new packageLoggers.
	packageA2 := RFiFragileBaseClassProblemResources4A new packageLoggers.
	packageB := RFiFragileBaseClassProblemResources4B new packageLoggers.
	
	envA := (baseEnvironment ficusPackages asArray copyWith: packageA) asFiSet asRFiEnvironment.
	envA2:= (baseEnvironment ficusPackages asArray copyWith: packageA2) asFiSet asRFiEnvironment.
	envB := (baseEnvironment ficusPackages asArray copyWith: packageB) asFiSet asRFiEnvironment.
	delta := envA2 ficusPackages differenceFrom: envA ficusPackages.
	
	builder := RFiLDeltaImpactBuilder new.
	builder origin: envA.
	builder destination: envB.
	builder delta: delta.
	
	time := [deltaImpacts := builder deltaImpacts] timeToRun.
	
	deltaImpacts inspect.	
	time inspect.
	

]

{ #category : #examples }
RFiLDeltaImpactBuilder class >> exampleYrupe [
	"
	self exampleYrupe
	"

	self exampleFragileBaseProblemWithBaseEnvironment: (YrPharoMigrator example1readTag: '30014') asRFiEnvironment
]

{ #category : #API }
RFiLDeltaImpactBuilder >> delta: aFiEffect [

	self flag: #todo. "Wrong!"
	
	delta := aFiEffect.
	deltaSimpleEffectsArray := delta asSimpleEffects asArray.
]

{ #category : #private }
RFiLDeltaImpactBuilder >> deltaEdit [

	self flag: #todo. "ARGH... this seems to be the most precise way to get an edit from a delta"
	^ origin ficusPackages editFromSimpleEffects: delta asSimpleEffects
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
	anEnvironmentPlusDelta := (anEnvironment ficusPackages resultOf: self deltaEdit) asRFiEnvironment.
	
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
	
	^ deltaSimpleEffectsArray anySatisfy: [ :simpleEffect | 
		simpleEffect hasEffectAt: anEntity asMetamodelSpot ]
]
