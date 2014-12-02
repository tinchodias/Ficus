Class {
	#name : #FiClassDependenciesCollectorTest,
	#superclass : #TestCase,
	#instVars : [
		'ringObjectResource'
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
	
	ringObjectResource := FiRGObjectResource new
]

{ #category : #tests }
FiClassDependenciesCollectorTest >> testClassA [

	self 
		assertDependenciesOf: ringObjectResource classA
		equals: {
			}
]

{ #category : #tests }
FiClassDependenciesCollectorTest >> testClassB [

	self 
		assertDependenciesOf: ringObjectResource classB
		equals: {
			FiClassReference builder
				theName: #A;
				new
				}
]
