"
A FiLDependencyGraphBuilderTest is a test class for testing the behavior of FiLDependencyGraphBuilder
"
Class {
	#name : #FiLDependencyGraphBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'environment',
		'graph'
	],
	#category : #'FicusImpact-LGraph'
}

{ #category : #tests }
FiLDependencyGraphBuilderTest >> test01 [

	| methods classes |
	environment := RFiFragileBaseClassProblemResources5A new ficusRGEnvironment.
	graph := FiLDependencyGraphBuilder graphForEnvironment: environment.
	
	methods := environment packages flatCollect: #definedMethods.
	classes := methods collect: #methodClass as: Set.

	self assert: (graph nodes collect: #contents as: Set) isNotEmpty.

	self assert: graph size <= (methods size + classes size).
]
