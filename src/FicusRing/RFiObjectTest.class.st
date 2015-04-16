Class {
	#name : #RFiObjectTest,
	#superclass : #TestCase,
	#instVars : [
		'resources'
	],
	#category : #'FicusRing-Tests'
}

{ #category : #running }
RFiObjectTest >> setUp [

	super setUp.
	
	resources := RFiRingTestResources new
]
