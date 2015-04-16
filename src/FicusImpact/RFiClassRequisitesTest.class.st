Class {
	#name : #RFiClassRequisitesTest,
	#superclass : #TestCase,
	#instVars : [
		'resources'
	],
	#category : #'FicusImpact-Tests'
}

{ #category : #private }
RFiClassRequisitesTest >> assertRequisitesOf: aFiRGClass equals: dependencies [
	
	self 
		assert: aFiRGClass ficusRequisites asSet 
		equals: dependencies asSet
]

{ #category : #running }
RFiClassRequisitesTest >> setUp [

	super setUp.
	
	resources := RFiRingTestResources new
]

{ #category : #tests }
RFiClassRequisitesTest >> testClassA [

	self 
		assertRequisitesOf: resources ringClassA
		equals: {
			RFiInheritanceDeclaration builder
				theClassName: #Object;
				new
			}
]

{ #category : #tests }
RFiClassRequisitesTest >> testClassB [

	self 
		assertRequisitesOf: resources ringClassB
		equals: {
			RFiInheritanceDeclaration builder
				theClassName: #A;
				new
				}
]

{ #category : #tests }
RFiClassRequisitesTest >> testClassObject [

	self 
		assertRequisitesOf: resources ringClassObject
		equals: {
			}
]
