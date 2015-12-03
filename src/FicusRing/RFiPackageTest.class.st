Class {
	#name : #RFiPackageTest,
	#superclass : #RFiObjectTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
RFiPackageTest >> testDefinedClasses [

	self 
		assert: (resources ringClassA package definedClasses collect: #name) asSet
		equals: #(A B C P T1) asSet.
]

{ #category : #tests }
RFiPackageTest >> testDefinedMethods [

	| resources2 package |
	resources2 := RFiRingTestResources new ringEnvironment.

	package := resources2 packages detect: [ :each | each name = #X ].
	self assert: (package definedMethods asSet 
		includes: ((resources2 classNamed: #A) >> #sum)).
	self assert: (package definedMethods asSet 
		includes: ((resources2 classNamed: #A) classSide >> #initialize)).
		
	package := resources2 packages detect: [ :each | each name = #Y ].
	self 
		assert: package definedMethods asSet
		equals: { 
			(resources2 classNamed: #A) >> #sum43. 
			(resources2 classNamed: #A) classSide >> #metaSum43 } asSet.
]

{ #category : #tests }
RFiPackageTest >> testIncludesClass [

	self assert: (resources ringClassA package includesClass: resources ringClassA)
]

{ #category : #tests }
RFiPackageTest >> testName [

	self 
		assert: (resources ringEnvironment packages collect: #name) asSet 
		equals: #(Kernel X Y) asSet.
]
