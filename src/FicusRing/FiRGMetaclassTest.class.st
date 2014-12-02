Class {
	#name : #FiRGMetaclassTest,
	#superclass : #FiRGBehaviorTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiRGMetaclassTest >> testEnvironment [
		
	| environment |
	environment := ringObjectResource environmentWithClassesABC.
	
	self assert: (environment classNamed: #A) theMetaClass environment == environment
]

{ #category : #tests }
FiRGMetaclassTest >> testMethods [

	self assert: ringObjectResource classA theMetaClass methods isEmpty.

]

{ #category : #tests }
FiRGMetaclassTest >> testSelectorsAndMethodsDo [

	| results |
	results := OrderedCollection new.
	
	ringObjectResource classA theMetaClass selectorsAndMethodsDo: [ :selector :method |
		results add: selector -> method ].

	self assert: results isEmpty.
]

{ #category : #tests }
FiRGMetaclassTest >> testSubclasses [

	self 
		assert: ringObjectResource classA theMetaClass subclasses 
		equals: { ringObjectResource classB theMetaClass }.

	self assert: ringObjectResource classB theMetaClass subclasses isEmpty.
]

{ #category : #tests }
FiRGMetaclassTest >> testTheNonMetaClass [

	| classA |
	classA := ringObjectResource classA.
	self assert: classA theMetaClass theNonMetaClass == classA
]
