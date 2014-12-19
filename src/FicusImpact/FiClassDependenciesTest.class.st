Class {
	#name : #FiClassDependenciesTest,
	#superclass : #TestCase,
	#instVars : [
		'resources'
	],
	#category : #'FicusImpact-Tests'
}

{ #category : #private }
FiClassDependenciesTest >> assertDependenciesOf: aFiRGClass equals: dependencies [
	
	self 
		assert: aFiRGClass ficusDependencies asSet 
		equals: dependencies asSet
]

{ #category : #running }
FiClassDependenciesTest >> setUp [

	super setUp.
	
	resources := FiRGObjectRingTestResources new
]

{ #category : #tests }
FiClassDependenciesTest >> testClassA [

	self 
		assertDependenciesOf: resources classA
		equals: {
			}
]

{ #category : #tests }
FiClassDependenciesTest >> testClassB [

	self 
		assertDependenciesOf: resources classB
		equals: {
			FiInheritanceDeclaration builder
				theClassName: #A;
				new
				}
]
