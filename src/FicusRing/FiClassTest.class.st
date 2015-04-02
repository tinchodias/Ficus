Class {
	#name : #FiClassTest,
	#superclass : #TestCase,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiClassTest >> testDefinition [

	| resources |
	resources := FiRingTestResources new.
	
	self 
		assert: resources classObject definition 
		equals: 'ProtoObject subclass: #Object
	uses: {}
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''Kernel''.
Object superclass: nil'.

	self 
		assert: resources classA definition 
		equals: 'Object subclass: #A
	uses: {}
	instanceVariableNames: ''a1 a2''
	classVariableNames: ''SomeClassVariable''
	poolDictionaries: ''P''
	category: ''NoCategory'''.
]
