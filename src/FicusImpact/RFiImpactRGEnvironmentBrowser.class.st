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
RFiImpactRGEnvironmentBrowser >> browseUsesOf: aFiRGObject [

	| node entities |
	node := self dependencyGraph nodeFor: aFiRGObject.
	entities := (node nodesPointingToMe collect: [:each | each contents ]).

	(RFiDependenciesBrowser openOn: entities)
		title: 'Uses of ', aFiRGObject shortPrintString.
]

{ #category : #private }
RFiImpactRGEnvironmentBrowser >> classesIn: aList [

	super classesIn: aList.
	self impactActionsIn: aList.
]

{ #category : #private }
RFiImpactRGEnvironmentBrowser >> dependencyGraph [

	^ dependencyGraph ifNil: [
		dependencyGraph := RFiLDependencyGraphBuilder graphForEnvironment: self entity ].
]

{ #category : #private }
RFiImpactRGEnvironmentBrowser >> impactActionsIn: aList [

	aList
		selectionAct: [:each :e | 
			self browseDependenciesOf: each selection ] 
			on: $d 
			entitled: 'Dependencies';
		selectionAct: [:each :e | 
			self browseUsesOf: each selection ] 
			on: $u 
			entitled: 'Uses'.
]

{ #category : #private }
RFiImpactRGEnvironmentBrowser >> sharedSetupForMethodsIn: aList [

	super sharedSetupForMethodsIn: aList.
	self impactActionsIn: aList.
]
