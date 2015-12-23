Class {
	#name : #RFiImpactRGEnvironmentBrowser,
	#superclass : #RFiEnvironmentBrowser,
	#instVars : [
		'dependencyGraph'
	],
	#category : #'FicusImpact-UI'
}

{ #category : #actions }
RFiImpactRGEnvironmentBrowser >> browseDependenciesOf: aRFiObject [

	| node entities |
	node := self dependencyGraph nodeFor: aRFiObject.
	entities := (node outgoingNodes collect: [:each | each contents ]).

	(RFiDependenciesBrowser openOn: entities)
		title: 'Dependencies of ', aRFiObject shortPrintString.
]

{ #category : #actions }
RFiImpactRGEnvironmentBrowser >> browseUsesOf: aRFiObject [

	| node entities |
	node := self dependencyGraph nodeFor: aRFiObject.
	entities := (node incomingNodes collect: [:each | each contents ]).

	(RFiDependenciesBrowser openOn: entities)
		title: 'Uses of ', aRFiObject shortPrintString.
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
