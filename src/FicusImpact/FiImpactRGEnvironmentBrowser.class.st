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

	| node |
	node := self dependencyGraph nodeFor: aFiRGObject.

	(FiDependenciesBrowser openOn: 
		(node outerEdges 
			collect: [:each | each target contents ] 
			as: Set))
		title: 'Dependencies of ', aFiRGObject shortPrintString.
]

{ #category : #actions }
FiImpactRGEnvironmentBrowser >> browseImpactsOf: aFiRGObject [

	| node |
	node := self dependencyGraph nodeFor: aFiRGObject.

	(FiDependenciesBrowser openOn: 
		(node innerEdges 
			collect: [:each | each source contents ] 
			as: Set))
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
