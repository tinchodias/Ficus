Class {
	#name : #FiRGMetaclassTest,
	#superclass : #FiRGBehaviorTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiRGMetaclassTest >> testEnvironment [
		
	| environment |
	environment := ringShotResource environmentWithClassesABC.
	
	self assert: (environment classNamed: #A) theMetaClass environment == environment
]

{ #category : #tests }
FiRGMetaclassTest >> testMethods [

	self assert: ringShotResource classA theMetaClass methods isEmpty.

]

{ #category : #tests }
FiRGMetaclassTest >> testSelectorsAndMethodsDo [

	| results |
	results := OrderedCollection new.
	
	ringShotResource classA theMetaClass selectorsAndMethodsDo: [ :selector :method |
		results add: selector -> method ].

	self assert: results isEmpty.
]

{ #category : #tests }
FiRGMetaclassTest >> testSubclasses [

	self 
		assert: ringShotResource classA theMetaClass subclasses 
		equals: { ringShotResource classB theMetaClass }.

	self assert: ringShotResource classB theMetaClass subclasses isEmpty.
]

{ #category : #tests }
FiRGMetaclassTest >> testTheNonMetaClass [

	| classA |
	classA := ringShotResource classA.
	self assert: classA theMetaClass theNonMetaClass == classA
]
