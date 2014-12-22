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
FiRGPackageTest >> testName [

	self 
		assert: (resources environmentWithAll packages collect: #name) asSet 
		equals: #(Kernel X) asSet.
]
