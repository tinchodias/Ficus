Class {
	#name : #RFiMetaclassTest,
	#superclass : #RFiBehaviorTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
RFiMetaclassTest >> testBinding [

	self 
		assert: resources ringClassA classSide binding 
		equals: nil -> resources ringClassA classSide

]

{ #category : #tests }
RFiMetaclassTest >> testBindingOf [

	self 
		assert: (resources ringClassA classSide bindingOf: #A) 
		equals: resources ringClassA binding

]

{ #category : #tests }
RFiMetaclassTest >> testDefinition [

	self 
		assert: resources ringClassA theMetaClass definition 
		equals: 'A class
	instanceVariableNames: ''a3'''
]

{ #category : #tests }
RFiMetaclassTest >> testEnvironment [
		
	| environment |
	environment := resources ringEnvironment.
	
	self assert: (environment classNamed: #A) theMetaClass environment == environment
]

{ #category : #tests }
RFiMetaclassTest >> testHasAbstractMethods [

	self deny: resources ringClassA classSide hasAbstractMethods.
]

{ #category : #tests }
RFiMetaclassTest >> testInstanceVariables [

	self 
		assert: resources ringClassA theMetaClass instanceVariables 
		equals: #(a3)

]

{ #category : #tests }
RFiMetaclassTest >> testIsBehavior [
		
	self assert: resources ringClassA classSide isBehavior.
	self assert: resources ringClassB classSide isBehavior.

]

{ #category : #tests }
RFiMetaclassTest >> testMethodDict [

	self assert: resources ringClassA theMetaClass methodDict isDictionary.
	self deny: resources ringClassA theMetaClass methodDict isEmpty.

	self assert: resources ringClassB theMetaClass methodDict isEmpty.

]

{ #category : #tests }
RFiMetaclassTest >> testMethods [

	self deny: resources ringClassA theMetaClass methods isEmpty.
	self assert: resources ringClassB theMetaClass methods isEmpty.

]

{ #category : #tests }
RFiMetaclassTest >> testName [

	self assert: resources ringClassA theMetaClass name equals: 'A class'
]

{ #category : #tests }
RFiMetaclassTest >> testPackage [
		
	self assert: resources ringClassA classSide package name equals: #X.
]

{ #category : #tests }
RFiMetaclassTest >> testRingInstanceVariableNamed [

	self deny: (resources ringClassA theMetaClass ringInstanceVariableNamed: 'a3') isNil.
	self deny: (resources ringClassA theMetaClass ringInstanceVariableNamed: #a3) isNil.

	self 
		assert: (resources ringClassA theMetaClass ringInstanceVariableNamed: 'a3') definingClass 
		equals: resources ringClassA theMetaClass
]

{ #category : #tests }
RFiMetaclassTest >> testRingInstanceVariables [

	self 
		assert: (resources ringClassA theMetaClass ringInstanceVariables collect: #name) asArray
		equals: #(a3)
]

{ #category : #tests }
RFiMetaclassTest >> testSelectorsAndMethodsDo [

	| results |
	results := OrderedCollection new.
	
	resources ringClassA theMetaClass selectorsAndMethodsDo: [ :selector :method |
		results add: method ].

	self 
		assert: results asSet
		equals: { 
			resources ringClassA classSide >> #initialize.
			resources ringClassA classSide >> #metaSum43 } asSet.

]

{ #category : #tests }
RFiMetaclassTest >> testSoleInstance [

	| classA |
	classA := resources ringClassA.
	self assert: classA theMetaClass soleInstance == classA
]

{ #category : #tests }
RFiMetaclassTest >> testSubclasses [

	self 
		assert: resources ringClassA theMetaClass subclasses 
		equals: { resources ringClassB theMetaClass }.

	self assert: resources ringClassB theMetaClass subclasses isEmpty.
]

{ #category : #tests }
RFiMetaclassTest >> testSuperclass [

	self assert: resources ringClassB theMetaClass superclass name equals: 'A class'.
]

{ #category : #tests }
RFiMetaclassTest >> testTheNonMetaClass [

	| classA |
	classA := resources ringClassA.
	self assert: classA theMetaClass theNonMetaClass == classA
]

{ #category : #tests }
RFiMetaclassTest >> testWhichSelectorAccess [
		
	self 
		assert: (resources ringClassA classSide whichSelectorsAccess: #a3) asSet 
		equals: { #initialize } asSet
]

{ #category : #tests }
RFiMetaclassTest >> testWhichSelectorsReferTo [
	"This was feature has been extracted from a real case in Pharo 4."

	self assert: (resources ringClassA classSide whichSelectorsReferTo: resources ringClassA binding) isNotEmpty.

]
