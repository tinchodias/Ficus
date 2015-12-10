Class {
	#name : #FiImpactRGEnvironmentBrowser,
	#superclass : #FiRGEnvironmentBrowser,
	#instVars : [
		'dependencyGraph'
	],
	#category : #'FicusImpact-UI'
}

{ #category : #actions }
FiImpactRGEnvironmentBrowser >> browseDependenciesOf: aFiRGObject [

	| node entities |
	node := self dependencyGraph nodeFor: aFiRGObject.
	entities := (node nodesPointedByMe collect: [:each | each contents ]).

	(FiDependenciesBrowser openOn: entities)
		title: 'Dependencies of ', aFiRGObject shortPrintString.
]

{ #category : #actions }
FiImpactRGEnvironmentBrowser >> browseImpactsOf: aFiRGObject [

	| node entities |
	node := self dependencyGraph nodeFor: aFiRGObject.
	entities := (node nodesPointingToMe collect: [:each | each contents ]).

	(FiDependenciesBrowser openOn: entities)
		title: 'Impacts of ', aFiRGObject shortPrintString.
]

{ #category : #private }
FiImpactRGEnvironmentBrowser >> classesIn: aList [

	super classesIn: aList.

	aList
		selectionAct: [:each :e | 
			self browseDependenciesOf: each selection ] 
			on: $d 
			entitled: 'Dependencies';
		selectionAct: [:each :e | 
			self browseImpactsOf: each selection ] 
			on: $i 
			entitled: 'Impacts'.
]

{ #category : #actions }
FiImpactRGEnvironmentBrowser >> dependencyGraph [

	^ dependencyGraph ifNil: [
		dependencyGraph := FiDependencyGraphBuilder graphForEnvironment: self entity ].
]

{ #category : #private }
FiImpactRGEnvironmentBrowser >> sharedSetupForMethodsIn: aList [

	super sharedSetupForMethodsIn: aList.

	aList
		selectionAct: [:each :e | 
			self browseDependenciesOf: each selection ] 
			on: $d 
			entitled: 'Dependencies';
		selectionAct: [:each :e | 
			self browseImpactsOf: each selection ] 
			on: $i 
			entitled: 'Impacts'.
]
