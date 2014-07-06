Class {
	#name : #FiClassDependenciesCollectorTest,
	#superclass : #TestCase,
	#instVars : [
		'ringShotResource'
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
	
	ringShotResource := FiRGShotResource new
]

{ #category : #tests }
FiClassDependenciesCollectorTest >> testClassA [

	self 
		assertDependenciesOf: ringShotResource classA
		equals: {
			}
]

{ #category : #tests }
FiClassDependenciesCollectorTest >> testClassB [

	self 
		assertDependenciesOf: ringShotResource classB
		equals: {
			FiClassReference builder
				theName: #A;
				new
				}
]
