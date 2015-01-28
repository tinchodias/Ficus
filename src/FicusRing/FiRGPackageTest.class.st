Class {
	#name : #FiRGPackageTest,
	#superclass : #FiRGObjectTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiRGPackageTest >> testDefinedClasses [

	self 
		assert: (resources classA package definedClasses collect: #name) asSet
		equals: #(A B C) asSet.
]

{ #category : #tests }
FiRGPackageTest >> testDefinedMethods [

	| resources2 package |
	resources2 := FiRingTestWithExtensionsResources new environmentWithAll asFiRGEnvironment.

	package := resources2 packages detect: [ :each | each name = #X ].
	self assert: (package definedMethods asSet 
		includes: ((resources2 classNamed: #A) >> #sum)).
	self assert: (package definedMethods asSet 
		includes: ((resources2 classNamed: #A) classSide >> #initialize)).
		
	package := resources2 packages detect: [ :each | each name = #Y ].
	self 
		assert: package definedMethods asSet
		equals: { (resources2 classNamed: #A) >> #sum43 } asSet.
]

{ #category : #tests }
FiRGPackageTest >> testName [

	self 
		assert: (resources environmentWithAll packages collect: #name) asSet 
		equals: #(Kernel X) asSet.
]
