Class {
	#name : #FiRGPackageTest,
	#superclass : #FiRGObjectTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiRGPackageTest >> testDefinedClasses [

	self 
		assert: (resources ringClassA package definedClasses collect: #name) asSet
		equals: #(A B C) asSet.
]

{ #category : #tests }
FiRGPackageTest >> testName [

	self 
		assert: (resources ficusRGEnvironment packages collect: #name) asSet 
		equals: #(Kernel X) asSet.
]
