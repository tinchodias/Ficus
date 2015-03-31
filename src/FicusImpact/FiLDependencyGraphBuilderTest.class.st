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

{ #category : #'as yet unclassified' }
FiLDependencyGraphBuilderTest >> test01 [

	| methods classes |
	environment := FiFragileBaseClassProblemResources5A new ficusRGEnvironment.
	graph := FiLDependencyGraphBuilder graphForEnvironment: environment.
	
	methods := environment packages flatCollect: #definedMethods.
	classes := methods collect: #methodClass as: Set.

	"maybe wrong asserts:"
	self 
		assert: (graph nodes collect: #contents as: Set)
		equals: (Set withAll: methods, classes).		
	self 
		assert: graph size 
		equals: (methods size + classes size).
]
