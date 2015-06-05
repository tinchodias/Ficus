Class {
	#name : #RFiPlaygroundTest,
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
RFiPlaygroundTest >> setUp [

	store := FiMemoryStore exampleFragileBaseProblem.

	node4B := store headHistoryNode.
	node3 := node4B priors anyOne.
	node2 := node3 priors anyOne.

	envB := node4B snapshot asRFiEnvironment.
	env3 := node3 snapshot asRFiEnvironment.
	env2 := node2 snapshot asRFiEnvironment.


]

{ #category : #tests }
RFiPlaygroundTest >> test01ficusPathFromEnvironment [

	| aClass aMethod |
	aClass := envB classNamed: #Log.
	aMethod := aClass >> #log:.

	self 
		assert: aClass asMetamodelSpot 
		equals: (FiBehaviorSpot
			name: #Log
			isMetaSide: false 
			packageName: #Loggers).

	self 
		assert: aClass theMetaClass asMetamodelSpot 
		equals: (FiBehaviorSpot
			name: #Log
			isMetaSide: true
			packageName: #Loggers).

	self 
		assert: aMethod asMetamodelSpot 
		equals: (FiMethodSpot
			selector: #log:
			behaviorName: #Log
			isMetaSide: false
			packageName: #Loggers).

	self 
		assert: ((envB classNamed: #Object) classSide >> #new) asMetamodelSpot 
		equals: (FiMethodSpot
			selector: #new
			behaviorName: #Object
			isMetaSide: true
			packageName: #Kernel).

]

{ #category : #tests }
RFiPlaygroundTest >> test02mostRecentHistoryNodeChanging [

	| aClass aMethod otherMethod |
	aClass := envB classNamed: #Log.
	aMethod := aClass >> #log:.
	otherMethod := aClass >> #logAll:.

	self flag: #todo. "Remove the fucking 'asPathOn: envB ficusEnvironment'"

	self 
		assert: (node4B mostRecentHistoryNodeChanging: (aClass asMetamodelSpot asPathOn: envB ficusEnvironment)) 
		equals: node4B.
	self 
		assert: (node4B mostRecentHistoryNodeChanging: (aMethod asMetamodelSpot asPathOn: envB ficusEnvironment)) 
		equals: node2.
	self 
		assert: (node4B mostRecentHistoryNodeChanging: (otherMethod asMetamodelSpot asPathOn: envB ficusEnvironment)) 
		equals: node4B.
]

{ #category : #tests }
RFiPlaygroundTest >> test03ChangeDependencies [

	| aClass aMethod aFiDelta dependencies pathsToDependencies |
	aClass := envB classNamed: #Log.
	aMethod := aClass >> #log:.

	aFiDelta := node4B snapshot differenceFrom: node3 snapshot.
	dependencies := envB ficusDependenciesForRedoing: aFiDelta asSimpleEffects anyOne.

	self assert: dependencies isNotEmpty.
	pathsToDependencies := dependencies asSet flatCollect: [ :dep | 
		dep targets collect: #asMetamodelSpot ].

	self 
		assert: pathsToDependencies 
		equals: {
			(FiMethodSpot 
				selector: #addAll: 
				behaviorName: #Collection 
				isMetaSide: false 
				packageName: #Collections).
			(FiBehaviorSpot 
				name: #Log 
				isMetaSide: false
				packageName: #Loggers) / #layout/ #instanceVariables / #collection.
			} asSet
]
