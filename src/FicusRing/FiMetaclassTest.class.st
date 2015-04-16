Class {
	#name : #FiMetaclassTest,
	#superclass : #TestCase,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiMetaclassTest >> testDefinition [

	| resources |
	resources := RFiRingTestResources new.
	
	self 
		assert: resources classA metaclass definition 
		equals: 'Metaclass
	uses: ''{}''
	instanceVariableNames: ''a3'''
]
