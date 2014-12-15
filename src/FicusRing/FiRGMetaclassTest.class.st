Class {
	#name : #FiRGMetaclassTest,
	#superclass : #FiRGBehaviorTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiRGMetaclassTest >> testEnvironment [
		
	| environment |
	environment := resources environmentWithClassesABC.
	
	self assert: (environment classNamed: #A) theMetaClass environment == environment
]

{ #category : #tests }
FiRGMetaclassTest >> testMethods [

	self assert: resources classA theMetaClass methods isEmpty.

]

{ #category : #tests }
FiRGMetaclassTest >> testSelectorsAndMethodsDo [

	| results |
	results := OrderedCollection new.
	
	resources classA theMetaClass selectorsAndMethodsDo: [ :selector :method |
		results add: selector -> method ].

	self assert: results isEmpty.
]

{ #category : #tests }
FiRGMetaclassTest >> testSubclasses [

	self 
		assert: resources classA theMetaClass subclasses 
		equals: { resources classB theMetaClass }.

	self assert: resources classB theMetaClass subclasses isEmpty.
]

{ #category : #tests }
FiRGMetaclassTest >> testTheNonMetaClass [

	| classA |
	classA := resources classA.
	self assert: classA theMetaClass theNonMetaClass == classA
]
