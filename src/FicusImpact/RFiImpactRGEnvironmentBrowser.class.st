Class {
	#name : #RFiImpactRGEnvironmentBrowser,
	#superclass : #RFiEnvironmentBrowser,
	#instVars : [
		'dependencyGraph'
	],
	#category : #'FicusImpact-UI'
}

{ #category : #actions }
RFiImpactRGEnvironmentBrowser >> browseDependenciesOf: aFiRGObject [

	| node entities |
	node := self dependencyGraph nodeFor: aFiRGObject.
	entities := (node nodesPointedByMe collect: [:each | each contents ]).

	(RFiDependenciesBrowser openOn: entities)
		title: 'Dependencies of ', aFiRGObject shortPrintString.
]

{ #category : #actions }
RFiImpactRGEnvironmentBrowser >> browseImpactsOf: aFiRGObject [

	| node entities |
	node := self dependencyGraph nodeFor: aFiRGObject.
	entities := (node nodesPointingToMe collect: [:each | each contents ]).

	(RFiDependenciesBrowser openOn: entities)
		title: 'Impacts of ', aFiRGObject shortPrintString.
]

{ #category : #private }
RFiImpactRGEnvironmentBrowser >> classesIn: aList [

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
RFiImpactRGEnvironmentBrowser >> dependencyGraph [

	^ dependencyGraph ifNil: [
		dependencyGraph := RFiLDependencyGraphBuilder graphForEnvironment: self entity ].
]

{ #category : #private }
RFiImpactRGEnvironmentBrowser >> sharedSetupForMethodsIn: aList [

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
