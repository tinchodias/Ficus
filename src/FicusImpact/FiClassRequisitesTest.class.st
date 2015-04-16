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
	
	resources := RFiRingTestResources new
]

{ #category : #tests }
FiClassRequisitesTest >> testClassA [

	self 
		assertRequisitesOf: resources ringClassA
		equals: {
			FiInheritanceDeclaration builder
				theClassName: #Object;
				new
			}
]

{ #category : #tests }
FiClassRequisitesTest >> testClassB [

	self 
		assertRequisitesOf: resources ringClassB
		equals: {
			FiInheritanceDeclaration builder
				theClassName: #A;
				new
				}
]

{ #category : #tests }
FiClassRequisitesTest >> testClassObject [

	self 
		assertRequisitesOf: resources ringClassObject
		equals: {
			}
]
