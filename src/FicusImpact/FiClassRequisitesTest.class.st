Class {
	#name : #FiClassRequisitesTest,
	#superclass : #TestCase,
	#instVars : [
		'resources'
	],
	#category : #'FicusImpact-Tests'
}

{ #category : #private }
FiClassRequisitesTest >> assertRequisitesOf: aFiRGClass equals: dependencies [
	
	self 
		assert: aFiRGClass ficusRequisites asSet 
		equals: dependencies asSet
]

{ #category : #running }
FiClassRequisitesTest >> setUp [

	super setUp.
	
	resources := FiRGObjectRingTestResources new
]

{ #category : #tests }
FiClassRequisitesTest >> testClassA [

	self 
		assertRequisitesOf: resources classA
		equals: {
			}
]

{ #category : #tests }
FiClassRequisitesTest >> testClassB [

	self 
		assertRequisitesOf: resources classB
		equals: {
			FiInheritanceDeclaration builder
				theClassName: #A;
				new
				}
]
