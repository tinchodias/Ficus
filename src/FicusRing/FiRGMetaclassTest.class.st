Class {
	#name : #FiRGMetaclassTest,
	#superclass : #FiRGBehaviorTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiRGMetaclassTest >> testDefinition [

	self 
		assert: resources classA theMetaClass definition 
		equals: 'A class
	instanceVariableNames: '''''
]

{ #category : #tests }
FiRGMetaclassTest >> testEnvironment [
		
	| environment |
	environment := resources environmentWithAll.
	
	self assert: (environment classNamed: #A) theMetaClass environment == environment
]

{ #category : #tests }
FiRGMetaclassTest >> testInstanceVariables [

	self assert: resources classA theMetaClass instanceVariables isEmpty

]

{ #category : #tests }
FiRGMetaclassTest >> testIsBehavior [
		
	self assert: resources classA classSide isBehavior.
	self assert: resources classB classSide isBehavior.

]

{ #category : #tests }
FiRGMetaclassTest >> testMethodDict [

	self assert: resources classA theMetaClass methodDict isDictionary.
	self deny: resources classA theMetaClass methodDict isEmpty.

	self assert: resources classB theMetaClass methodDict isEmpty.

]

{ #category : #tests }
FiRGMetaclassTest >> testMethods [

	self deny: resources classA theMetaClass methods isEmpty.
	self assert: resources classB theMetaClass methods isEmpty.

]

{ #category : #tests }
FiRGMetaclassTest >> testName [

	self assert: resources classA theMetaClass name equals: 'A class'
]

{ #category : #tests }
FiRGMetaclassTest >> testPackage [
		
	self assert: resources classA classSide package name equals: #X.
]

{ #category : #tests }
FiRGMetaclassTest >> testSelectorsAndMethodsDo [

	| results |
	results := OrderedCollection new.
	
	resources classA theMetaClass selectorsAndMethodsDo: [ :selector :method |
		results add: selector -> method ].

	self 
		assert: results asArray 
		equals: { #initialize -> (resources classA classSide >> #initialize) }.

]

{ #category : #tests }
FiRGMetaclassTest >> testSoleInstance [

	| classA |
	classA := resources classA.
	self assert: classA theMetaClass soleInstance == classA
]

{ #category : #tests }
FiRGMetaclassTest >> testSubclasses [

	self 
		assert: resources classA theMetaClass subclasses 
		equals: { resources classB theMetaClass }.

	self assert: resources classB theMetaClass subclasses isEmpty.
]

{ #category : #tests }
FiRGMetaclassTest >> testSuperclass [

	self assert: resources classB theMetaClass superclass name equals: 'A class'.
]

{ #category : #tests }
FiRGMetaclassTest >> testTheNonMetaClass [

	| classA |
	classA := resources classA.
	self assert: classA theMetaClass theNonMetaClass == classA
]
