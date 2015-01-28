Class {
	#name : #FiRGObjectTest,
	#superclass : #TestCase,
	#instVars : [
		'resources'
	],
	#category : #'FicusRing-Tests'
}

{ #category : #running }
FiRGObjectTest >> setUp [

	super setUp.
	
	resources := FiRingTestResources new
]
