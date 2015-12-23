"
A RFiLDeltaImpactBuilderTest is a test class for testing the behavior of RFiLDeltaImpactBuilder
"
Class {
	#name : #RFiLDeltaImpactBuilderTest,
	#superclass : #TestCase,
	#category : #'FicusImpact-Tests'
}

{ #category : #tests }
RFiLDeltaImpactBuilderTest >> testExample1 [

	| deltaImpact |
	deltaImpact := RFiLDeltaImpactBuilder example1.

	self deny: deltaImpact first isEmpty.
	self assert: deltaImpact second isEmpty
]
