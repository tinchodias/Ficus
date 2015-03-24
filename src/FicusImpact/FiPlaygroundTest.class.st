Class {
	#name : #FiPlaygroundTest,
	#superclass : #TestCase,
	#instVars : [
		'store',
		'nodeB',
		'node0',
		'envB',
		'env0'
	],
	#category : #'FicusImpact-Tests'
}

{ #category : #running }
FiPlaygroundTest >> setUp [

	store := FiMemoryStore exampleFragileBaseProblem.

	nodeB := store headHistoryNode.
	node0 := nodeB priors asArray anyOne.

	envB := nodeB snapshot asFiRGEnvironment.
	env0 := node0 snapshot asFiRGEnvironment.


]

{ #category : #tests }
FiPlaygroundTest >> test01ficusPathFromEnvironment [

	| aClass aMethod |
	aClass := envB classNamed: #Log.
	aMethod := aClass >> #log:.

	self assert: aClass ficusPathFromEnvironment equals: #(Loggers contents Log) asFiPath.
	self assert: aMethod ficusPathFromEnvironment equals: #(Loggers contents Log methods log:) asFiPath.

]

{ #category : #tests }
FiPlaygroundTest >> test02mostRecentHistoryNodeChanging [

	| aClass aMethod |
	aClass := envB classNamed: #Log.
	aMethod := aClass >> #log:.

	self assert: (nodeB mostRecentHistoryNodeChanging: aClass ficusPathFromEnvironment) = nodeB.
	self assert: (nodeB mostRecentHistoryNodeChanging: aMethod ficusPathFromEnvironment) = node0.
	self assert: (nodeB mostRecentHistoryNodeChanging: (aClass >> #logAll:) ficusPathFromEnvironment) = nodeB.
]

{ #category : #tests }
FiPlaygroundTest >> test03ChangeDependencies [

	| aClass aMethod aFiDelta dependencies pathsToDependencies |
	aClass := envB classNamed: #Log.
	aMethod := aClass >> #log:.

	aFiDelta := nodeB snapshot differenceFrom: node0 snapshot.
	dependencies := envB ficusDependenciesForRedoing: aFiDelta asSimpleEffects anyOne.
	self assert: dependencies isNotEmpty.
	pathsToDependencies := dependencies asSet flatCollect: [ :dep | 
		dep targets collect: #ficusPathFromEnvironment ].

	self 
		assert: pathsToDependencies 
		equals: {
			FiPath root / #Collections / #contents / #Collection / #methods / #addAll:. 
			FiPath root / #Loggers / #contents / #Log
			} asSet
]
