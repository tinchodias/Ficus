"
A FiLDependencyGraphBuilderTest is a test class for testing the behavior of FiLDependencyGraphBuilder
"
Class {
	#name : #RFiLDependencyGraphBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'environment',
		'graph'
	],
	#category : #'FicusImpact-LGraph'
}

{ #category : #tests }
RFiLDependencyGraphBuilderTest >> test01 [

	| methods classes |
	environment := RFiFragileBaseClassProblemResources5A new ringEnvironment.
	graph := RFiLDependencyGraphBuilder graphForEnvironment: environment.
	
	methods := environment packages flatCollect: #definedMethods.
	classes := methods collect: #methodClass as: Set.

	self assert: (graph nodes collect: #contents as: Set) isNotEmpty.

	self assert: graph size equals: 68.
]
