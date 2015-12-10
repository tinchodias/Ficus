Class {
	#name : #FiPlaygroundTest,
	#superclass : #TestCase,
	#instVars : [
		'store',
		'envB',
		'node2',
		'node4B',
		'node3',
		'env3',
		'env2'
	],
	#category : #'FicusImpact-Tests'
}

{ #category : #running }
FiPlaygroundTest >> setUp [

	store := FiMemoryStore exampleFragileBaseProblem.

	node4B := store headHistoryNode.
	node3 := node4B priors anyOne.
	node2 := node3 priors anyOne.

	envB := node4B snapshot asFiRGEnvironment.
	env3 := node3 snapshot asFiRGEnvironment.
	env2 := node2 snapshot asFiRGEnvironment.


]

{ #category : #tests }
FiPlaygroundTest >> test01ficusPathFromEnvironment [

	| aClass aMethod |
	aClass := envB classNamed: #Log.
	aMethod := aClass >> #log:.

	self 
		assert: aClass ficusPathFromEnvironment 
		equals: #(Loggers contents Log) asFiPath.

	self 
		assert: aClass theMetaClass ficusPathFromEnvironment 
		equals: #(Loggers contents Log metaclass) asFiPath.

	self 
		assert: aMethod ficusPathFromEnvironment 
		equals: #(Loggers contents Log methods log:) asFiPath.

	self 
		assert: ((envB classNamed: #Object) classSide >> #new) ficusPathFromEnvironment 
		equals: #(Kernel contents Object metaclass methods new) asFiPath.

]

{ #category : #tests }
FiPlaygroundTest >> test02mostRecentHistoryNodeChanging [

	| aClass aMethod |
	aClass := envB classNamed: #Log.
	aMethod := aClass >> #log:.

	self assert: (node4B mostRecentHistoryNodeChanging: aClass ficusPathFromEnvironment) = node4B.
	self assert: (node4B mostRecentHistoryNodeChanging: aMethod ficusPathFromEnvironment) = node2.
	self assert: (node4B mostRecentHistoryNodeChanging: (aClass >> #logAll:) ficusPathFromEnvironment) = node4B.
]

{ #category : #tests }
FiPlaygroundTest >> test03ChangeDependencies [

	| aClass aMethod aFiDelta dependencies pathsToDependencies |
	aClass := envB classNamed: #Log.
	aMethod := aClass >> #log:.

	aFiDelta := node4B snapshot differenceFrom: node3 snapshot.
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
