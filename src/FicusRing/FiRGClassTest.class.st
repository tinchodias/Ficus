Class {
	#name : #FiRGClassTest,
	#superclass : #FiRGBehaviorTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiRGClassTest >> testAllCallsOn [

	self 
		assert: (resources ringClassA allCallsOn 
		includes: (resources ringClassA classSide >> #initialize) asActiveRingDefinition).
	"Brrrrrrrrrrr"
]

{ #category : #tests }
FiRGClassTest >> testAllInstVarNames [

	self assert: resources ringClassA allInstVarNames asSet equals: #('a1' 'a2') asSet.
	self assert: resources ringClassB allInstVarNames asSet equals: #('a1' 'a2' 'b1') asSet
]

{ #category : #tests }
FiRGClassTest >> testAllSelectors [

	self 
		assert: resources ringClassB allSelectors
		equals: (resources ringClassA selectors, resources ringClassB selectors) asSet

]

{ #category : #tests }
FiRGClassTest >> testAllSlots [

	self 
		assert: (resources ringClassA allSlots collect: #name) asSet 
		equals: #(a1 a2) asSet.
		
	self 
		assert: (resources ringClassB allSlots collect: #name) asSet 
		equals: #(a1 a2 b1) asSet.
]

{ #category : #tests }
FiRGClassTest >> testAllSubclasses [

	self assert: resources ringClassA allSubclasses asArray equals: { resources ringClassB }.
]

{ #category : #tests }
FiRGClassTest >> testAllSubclassesDo [

	| result |
	result := OrderedCollection new.
	resources ringClassA allSubclassesDo: [ :aSubclass | result add: aSubclass ].
	
	self assert: result asArray equals: { resources ringClassB }.
]

{ #category : #tests }
FiRGClassTest >> testAllSuperclasses [

	self assert: resources ringClassB allSuperclasses asArray equals: { resources ringClassA }.
]

{ #category : #tests }
FiRGClassTest >> testAllSuperclassesDo [

	| result |
	result := OrderedCollection new.
	resources ringClassB allSuperclassesDo: [ :aSuperclass | result add: aSuperclass ].
	
	self assert: result asArray equals: { resources ringClassA }.
]

{ #category : #tests }
FiRGClassTest >> testBinding [

	self 
		assert: resources ringClassA binding 
		equals: #A -> resources ringClassA

]

{ #category : #tests }
FiRGClassTest >> testBindingOf [

	"for an undeclared"
	self assert: (resources ringClassB bindingOf: #UnexistentClass) isNil.

	"for a global"	
	self deny: (resources ringClassB bindingOf: #A) isNil.
	self assert: (resources ringClassB bindingOf: #A) equals: (resources ficusRGEnvironment bindingOf: #A).

	"for a class variable"
	self deny: (resources ringClassA bindingOf: #SomeClassVariable) isNil.
"	self assert: (classB bindingOf: #BConstants) equals: (ringShotResource environmentWithClassesABC bindingOf: #A)."

	self flag: #todo. "Functionality missing: SHAREDPOOLS"


]

{ #category : #tests }
FiRGClassTest >> testCanUnderstand [

	self assert: (resources ringClassA canUnderstand: #sum42).
	self assert: (resources ringClassB canUnderstand: #sum42).

	self deny: (resources ringClassA canUnderstand: #defaultClass).
	self assert: (resources ringClassB canUnderstand: #defaultClass).

]

{ #category : #'tests-polymorphism' }
FiRGClassTest >> testClassPool [

	self assert: resources ringClassA classPool isDictionary.
	self assert: resources ringClassA classPool keys asSet equals: #(SomeClassVariable) asSet.

	self assert: resources ringClassB classPool isEmpty.
]

{ #category : #tests }
FiRGClassTest >> testClassVarNames [

	self assert: resources ringClassA classVarNames equals: #('SomeClassVariable').
	self assert: resources ringClassB classVarNames isEmpty
]

{ #category : #tests }
FiRGClassTest >> testCompiledMethodAt [
		
	self assert: (resources ringClassA compiledMethodAt: #sum) isNotNil.
	self assert: (resources ringClassA >> #sum) isNotNil.

]

{ #category : #tests }
FiRGClassTest >> testCompiledMethodAtIfPresentIfAbsent [

	| presentOrNil |
	presentOrNil := nil.
		
	resources ringClassA 
		compiledMethodAt: #sum
		ifPresent: [ :method | presentOrNil := true ]
		ifAbsent: [ presentOrNil := false ].

	self assert: presentOrNil.

	
	presentOrNil := nil.
		
	resources ringClassA 
		compiledMethodAt: #unexistentMethod
		ifPresent: [ :method | presentOrNil := true ]
		ifAbsent: [ presentOrNil := false ].

	self deny: presentOrNil.
]

{ #category : #'tests-polymorphism' }
FiRGClassTest >> testDefinition [

	self 
		assert: resources ringClassA definition 
		equals: 'ProtoObject subclass: #A
	instanceVariableNames: ''a1 a2''
	classVariableNames: ''SomeClassVariable''
	poolDictionaries: ''''
	category: ''NoCategory''.
A superclass: nil'
]

{ #category : #tests }
FiRGClassTest >> testEnvironment [
		
	| environment |
	environment := resources ficusRGEnvironment.
	
	self assert: (environment classNamed: #A) environment == environment
]

{ #category : #tests }
FiRGClassTest >> testHasAbstractMethods [

	self deny: (resources ficusRGEnvironment classNamed: #True) hasAbstractMethods.
	self assert: (resources ficusRGEnvironment classNamed: #Boolean) hasAbstractMethods.

]

{ #category : #tests }
FiRGClassTest >> testIncludesSelector [
		
	self assert: (resources ringClassA includesSelector: #sum).
	self deny: (resources ringClassA includesSelector: #unexistentMethod).

]

{ #category : #tests }
FiRGClassTest >> testInstSize [
		
	self assert: resources ringClassA instSize equals: 2.
	self assert: resources ringClassB instSize equals: 3.

]

{ #category : #tests }
FiRGClassTest >> testInstVarNames [
		
	self assert: resources ringClassA instVarNames asSet equals: #('a1' 'a2') asSet.
	self assert: resources ringClassB instVarNames asSet equals: #('b1') asSet.

]

{ #category : #tests }
FiRGClassTest >> testInstanceVariables [
		
	self assert: resources ringClassA instanceVariables asSet equals: #('a1' 'a2') asSet.
	self assert: resources ringClassB instanceVariables asSet equals: #('b1') asSet.

]

{ #category : #tests }
FiRGClassTest >> testIsBehavior [
		
	self assert: resources ringClassA isBehavior.
	self assert: resources ringClassB isBehavior.

]

{ #category : #tests }
FiRGClassTest >> testIsObsolete [

	self deny: resources ringClassA isObsolete.

]

{ #category : #tests }
FiRGClassTest >> testLookupSelector [
		
	self deny: (resources ringClassA lookupSelector: #sum) isNil.
	self assert: (resources ringClassA lookupSelector: #unexistentMethod) isNil.

]

{ #category : #tests }
FiRGClassTest >> testMethodDict [

	| methodsWithoutExtensions methodsWithExtensions |
	methodsWithoutExtensions := resources ringClassA methodDict.
	methodsWithExtensions := (FiRingTestWithExtensionsResources new ficusRGEnvironment classNamed: #A) methodDict.

	self assert: methodsWithoutExtensions keys asSet equals: #(#sum #sum42) asSet.
	self assert: methodsWithExtensions keys asSet equals: #(#sum #sum42 #sum43) asSet.

]

{ #category : #tests }
FiRGClassTest >> testMethods [

	| methodsWithoutExtensions methodsWithExtensions |
	methodsWithoutExtensions := resources ringClassA methods.
	methodsWithExtensions := (FiRingTestWithExtensionsResources new ficusRGEnvironment classNamed: #A) methods.

	self assert: (methodsWithoutExtensions collect: #selector) asSet equals: #(#sum #sum42) asSet.
	self assert: (methodsWithExtensions collect: #selector) asSet equals: #(#sum #sum42 #sum43) asSet.

]

{ #category : #'tests-polymorphism' }
FiRGClassTest >> testName [

	self assert: resources ringClassA name equals: 'A'
]

{ #category : #tests }
FiRGClassTest >> testPackage [
		
	self assert: resources ringClassA package name equals: #X.
]

{ #category : #tests }
FiRGClassTest >> testParseTreeFor [
		
	self deny: (resources ringClassA parseTreeFor: #sum) isNil.
	self assert: (resources ringClassA parseTreeFor: #unexistentMethod) isNil.

]

{ #category : #tests }
FiRGClassTest >> testSelectors [

	self deny: resources ringClassA selectors isEmpty.
	self assert: (resources ringClassA selectors allSatisfy: #isSymbol).

]

{ #category : #tests }
FiRGClassTest >> testSelectorsAndMethodsDo [

	| results |
	results := OrderedCollection new.
	
	resources ringClassA selectorsAndMethodsDo: [ :selector :method |
		results add: selector -> method ].

	self assert: results isNotEmpty.
	results do: [ :association |
		self assert: association key equals: association value selector ]
]

{ #category : #tests }
FiRGClassTest >> testSharedPoolNames [

	self flag: #todo. "Test not empty case"
	self assert: resources ringClassA sharedPoolNames isEmpty.
]

{ #category : #tests }
FiRGClassTest >> testSharedPools [

	self flag: #todo. "Test not empty case"
	self assert: resources ringClassA sharedPools isEmpty.
]

{ #category : #tests }
FiRGClassTest >> testSourceCodeAtIfAbsent [
		
	self assert: (resources ringClassA sourceCodeAt: #unexistentMethod ifAbsent: [ '' ]) equals: ''.
	self 
		assert: (resources ringClassA sourceCodeAt: #sum ifAbsent: [ '' ]) 
		equals: (resources ringClassA >> #sum) sourceCode.

]

{ #category : #tests }
FiRGClassTest >> testSubclasses [

	self assert: resources ringClassA subclasses equals: { resources ringClassB }.
	self assert: resources ringClassB subclasses isEmpty.
]

{ #category : #tests }
FiRGClassTest >> testSubclassesDo [

	| result |
	result := OrderedCollection new.
	resources ringClassA subclassesDo: [ :aSubclass | result add: aSubclass ].
	
	self assert: result asArray equals: { resources ringClassB }.
]

{ #category : #tests }
FiRGClassTest >> testSuperclass [

	self assert: resources ringClassA superclass isNil.
	self assert: resources ringClassB superclass name equals: #A.
]

{ #category : #'tests-polymorphism' }
FiRGClassTest >> testTheMetaClass [

	self assert: resources ringClassA theMetaClass isMeta.

]

{ #category : #tests }
FiRGClassTest >> testTheNonMetaClass [
		
	| aClass |
	aClass := resources ringClassA.

	self assert: aClass theNonMetaClass == aClass.

]

{ #category : #tests }
FiRGClassTest >> testWhichCategoryIncludesSelector [
		
	self assert: (resources ringClassA whichCategoryIncludesSelector: #sum) equals: #'as yet unclassified'.

]

{ #category : #tests }
FiRGClassTest >> testWhichClassIncludesSelector [

	self deny: (resources ringClassA whichClassIncludesSelector: #sum) isNil.
	self assert: (resources ringClassA whichClassIncludesSelector: #unexistentMethod) isNil.
]

{ #category : #tests }
FiRGClassTest >> testWhichSelectorAccess [
		
	self assert: (resources ringClassA whichSelectorsAccess: #a1) asSet equals: { #sum } asSet
]

{ #category : #tests }
FiRGClassTest >> testWhichSelectorsRead [

	self 
		assert: (resources ringClassB whichSelectorsRead: #b1) asSet 
		equals: #(sum) asSet.
		
	self 
		assert: (resources ringClassB whichSelectorsRead: #a1) asSet 
		equals: #(variableInSuper) asSet.

]

{ #category : #'tests-polymorphism' }
FiRGClassTest >> testWhichSelectorsReferTo [

	self assert: (resources ringClassC whichSelectorsReferTo: #+) asArray equals: #(sumTmp)
]

{ #category : #tests }
FiRGClassTest >> testWhichSelectorsStoreInto [

	self 
		assert: (resources ringClassB whichSelectorsStoreInto: #b1) asSet 
		equals: #(initialize resetAll) asSet.
		
	self 
		assert: (resources ringClassB whichSelectorsStoreInto: #a1) asSet 
		equals: #(resetAll) asSet.

]

{ #category : #tests }
FiRGClassTest >> testWithAllSubclasses [

	self assert: resources ringClassA withAllSubclasses asArray equals: { resources ringClassB. resources ringClassA }.
]

{ #category : #tests }
FiRGClassTest >> testWithAllSuperAndSubclassesDo [

	| result |
	result := OrderedCollection new.
	resources ringClassA withAllSuperAndSubclassesDo: [ :aSubclass | result add: aSubclass ].
	
	self assert: result asArray equals: { resources ringClassA. resources ringClassB }.
]

{ #category : #'tests-polymorphism' }
FiRGClassTest >> testWithAllSuperclasses [

	self 
		assert: resources ringClassB withAllSuperclasses asArray 
		equals: { resources ringClassB. resources ringClassA }.
]
