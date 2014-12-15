Class {
	#name : #FiClassDependenciesCollectorTest,
	#superclass : #TestCase,
	#instVars : [
		'resources'
	],
	#category : #'FicusImpact-Tests'
}

{ #category : #private }
FiClassDependenciesCollectorTest >> assertDependenciesOf: aRingMethod equals: dependencies [
	
	self 
		assert: (FiClassDependenciesCollector new dependenciesFor: aRingMethod) asSet 
		equals: dependencies asSet
]

{ #category : #running }
FiClassDependenciesCollectorTest >> setUp [

	super setUp.
	
	resources := FiRGObjectResources new
]

{ #category : #tests }
FiClassDependenciesCollectorTest >> testClassA [

	self 
		assertDependenciesOf: resources classA
		equals: {
			}
]

{ #category : #tests }
FiClassDependenciesCollectorTest >> testClassB [

	self 
		assertDependenciesOf: resources classB
		equals: {
			FiClassReference builder
				theName: #A;
				new
				}
]
