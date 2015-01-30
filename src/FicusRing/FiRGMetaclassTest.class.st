Class {
	#name : #FiRGMetaclassTest,
	#superclass : #FiRGBehaviorTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiRGMetaclassTest >> testBinding [

	self 
		assert: resources ringClassA classSide binding 
		equals: nil -> resources ringClassA classSide

]

{ #category : #tests }
FiRGMetaclassTest >> testDefinition [

	self 
		assert: resources ringClassA theMetaClass definition 
		equals: 'A class
	instanceVariableNames: ''a3'''
]

{ #category : #tests }
FiRGMetaclassTest >> testEnvironment [
		
	| environment |
	environment := resources ficusRGEnvironment.
	
	self assert: (environment classNamed: #A) theMetaClass environment == environment
]

{ #category : #tests }
FiRGMetaclassTest >> testHasAbstractMethods [

	self deny: resources ringClassA classSide hasAbstractMethods.
]

{ #category : #tests }
FiRGMetaclassTest >> testInstanceVariables [

	self 
		assert: resources ringClassA theMetaClass instanceVariables 
		equals: #(a3)

]

{ #category : #tests }
FiRGMetaclassTest >> testIsBehavior [
		
	self assert: resources ringClassA classSide isBehavior.
	self assert: resources ringClassB classSide isBehavior.

]

{ #category : #tests }
FiRGMetaclassTest >> testMethodDict [

	self assert: resources ringClassA theMetaClass methodDict isDictionary.
	self deny: resources ringClassA theMetaClass methodDict isEmpty.

	self assert: resources ringClassB theMetaClass methodDict isEmpty.

]

{ #category : #tests }
FiRGMetaclassTest >> testMethods [

	self deny: resources ringClassA theMetaClass methods isEmpty.
	self assert: resources ringClassB theMetaClass methods isEmpty.

]

{ #category : #tests }
FiRGMetaclassTest >> testName [

	self assert: resources ringClassA theMetaClass name equals: 'A class'
]

{ #category : #tests }
FiRGMetaclassTest >> testPackage [
		
	self assert: resources ringClassA classSide package name equals: #X.
]

{ #category : #tests }
FiRGMetaclassTest >> testSelectorsAndMethodsDo [

	| results |
	results := OrderedCollection new.
	
	resources ringClassA theMetaClass selectorsAndMethodsDo: [ :selector :method |
		results add: selector -> method ].

	self 
		assert: results asArray 
		equals: { #initialize -> (resources ringClassA classSide >> #initialize) }.

]

{ #category : #tests }
FiRGMetaclassTest >> testSoleInstance [

	| classA |
	classA := resources ringClassA.
	self assert: classA theMetaClass soleInstance == classA
]

{ #category : #tests }
FiRGMetaclassTest >> testSubclasses [

	self 
		assert: resources ringClassA theMetaClass subclasses 
		equals: { resources ringClassB theMetaClass }.

	self assert: resources ringClassB theMetaClass subclasses isEmpty.
]

{ #category : #tests }
FiRGMetaclassTest >> testSuperclass [

	self assert: resources ringClassB theMetaClass superclass name equals: 'A class'.
]

{ #category : #tests }
FiRGMetaclassTest >> testTheNonMetaClass [

	| classA |
	classA := resources ringClassA.
	self assert: classA theMetaClass theNonMetaClass == classA
]

{ #category : #tests }
FiRGMetaclassTest >> testWhichSelectorAccess [
		
	self 
		assert: (resources ringClassA classSide whichSelectorsAccess: #a3) asSet 
		equals: { #initialize } asSet
]

{ #category : #tests }
FiRGMetaclassTest >> testWhichSelectorsReferTo [
	"This was feature has been extracted from a real case in Pharo 4."

	self assert: (resources ringClassA classSide whichSelectorsReferTo: resources ringClassA binding) isNotEmpty.

]
