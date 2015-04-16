Class {
	#name : #RFiInterpretedDependency,
	#superclass : #FiFixedObject,
	#instVars : [
		'requisite',
		'targets'
	],
	#category : #'FicusImpact-Dependencies'
}

{ #category : #examples }
RFiInterpretedDependency class >> example [

	| pkg1 pkg2 env1 env2 deps1 deps2 diff |
	pkg1 := RFiFragileBaseClassProblemResources5A new packageLoggers.

	pkg2 := pkg1 resultOf: (
			FiSubEdit
				path: #(contents Log methods log: sourceCode) asFiPath
				equal: 'log: aMessage  
		collection addFirst: aMessage').

	env1 := (RFiBaseResources new ficusEnvironment asArray copyWith: pkg1) asFiSet asRFiEnvironment.
	env2 := (RFiBaseResources new ficusEnvironment asArray copyWith: pkg2) asFiSet asRFiEnvironment.
	"
	env1 browse.
	env2 browse.
	"
	deps1 := ((env1 classNamed: #LRULogTest) >> #testLog) ficusInterpretedDependencies.
	deps2 := ((env2 classNamed: #LRULogTest) >> #testLog) ficusInterpretedDependencies.

	diff := deps2 differenceFrom: deps1.
	FiEffectInspector inspect: diff.

	FiInspector inspect: deps1.
	FiInspector inspect: deps2.

]

{ #category : #accessing }
RFiInterpretedDependency >> defaultStep [

	^ requisite shortPrintString
]

{ #category : #accessing }
RFiInterpretedDependency >> requisite [

	^ requisite
]

{ #category : #accessing }
RFiInterpretedDependency >> targets [

	^ targets
]
