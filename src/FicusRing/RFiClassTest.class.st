Class {
	#name : #RFiClassTest,
	#superclass : #RFiBehaviorTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
RFiClassTest >> testAllCallsOn [

	self 
		assert: (resources ringClassA allCallsOn 
		includes: (resources ringClassA classSide >> #initialize) asActiveRingDefinition).
	"Brrrrrrrrrrr"
]

{ #category : #tests }
RFiClassTest >> testAllInstVarNames [

	self assert: resources ringClassA allInstVarNames asSet equals: #('a1' 'a2') asSet.
	self assert: resources ringClassB allInstVarNames asSet equals: #('a1' 'a2' 'b1') asSet
]

{ #category : #tests }
RFiClassTest >> testAllSelectors [

	self 
		assert: resources ringClassB allSelectors
		equals: (resources ringClassObject selectors union: (resources ringClassA selectors union: resources ringClassB selectors)) asSet

]

{ #category : #tests }
RFiClassTest >> testAllSlots [

	self 
		assert: (resources ringClassA allSlots collect: #name) asSet 
		equals: #(a1 a2) asSet.
		
	self 
		assert: (resources ringClassB allSlots collect: #name) asSet 
		equals: #(a1 a2 b1) asSet.
]

{ #category : #tests }
RFiClassTest >> testAllSubclasses [

	self assert: resources ringClassA allSubclasses asArray equals: { resources ringClassB }.
]

{ #category : #tests }
RFiClassTest >> testAllSubclassesDo [

	| result |
	result := OrderedCollection new.
	resources ringClassA allSubclassesDo: [ :aSubclass | result add: aSubclass ].
	
	self assert: result asArray equals: { resources ringClassB }.
]

{ #category : #tests }
RFiClassTest >> testAllSuperclasses [

	self assert: resources ringClassB allSuperclasses asArray equals: { resources ringClassA. resources ringClassObject }.
]

{ #category : #tests }
RFiClassTest >> testAllSuperclassesDo [

	| result |
	result := OrderedCollection new.
	resources ringClassB allSuperclassesDo: [ :aSuperclass | result add: aSuperclass ].
	
	self assert: result asArray equals: { resources ringClassA. resources ringClassObject }.
]

{ #category : #tests }
RFiClassTest >> testBinding [

	self 
		assert: resources ringClassA binding 
		equals: #A -> resources ringClassA

]

{ #category : #tests }
RFiClassTest >> testBindingOf [

	"for an undeclared"
	self assert: (resources ringClassB bindingOf: #UnexistentClass) isNil.

	"for a global"	
	self deny: (resources ringClassB bindingOf: #A) isNil.
	self assert: (resources ringClassB bindingOf: #A) equals: resources ringClassA binding.

	"for a class variable"
	"(we assume that class variables have nil as value)"
	self 
		assert: (resources ringClassA bindingOf: #SomeClassVariable)
		equals: (#SomeClassVariable -> nil).
	self 
		assert: (resources ringClassB bindingOf: #SomeClassVariable)
		equals: (#SomeClassVariable -> nil).
	self assert: (resources ringClassC bindingOf: #SomeClassVariable) isNil.

	"for a shared pool variable"
	"(we assume that shared pools have nil as value)"
	self 
		assert: (resources ringClassA bindingOf: #SomeSharedPoolVariable) 
		equals: (#SomeSharedPoolVariable -> nil).
	self 
		assert: (resources ringClassB bindingOf: #SomeSharedPoolVariable) 
		equals: (#SomeSharedPoolVariable -> nil).
	self assert: (resources ringClassC bindingOf: #SomeSharedPoolVariable) isNil.

]

{ #category : #tests }
RFiClassTest >> testCanUnderstand [

	self assert: (resources ringClassA canUnderstand: #sum42).
	self assert: (resources ringClassB canUnderstand: #sum42).

	self deny: (resources ringClassA canUnderstand: #defaultClass).
	self assert: (resources ringClassB canUnderstand: #defaultClass).

]

{ #category : #tests }
RFiClassTest >> testClassPool [

	self assert: resources ringClassA classPool isDictionary.
	self assert: resources ringClassA classPool keys asSet equals: #(SomeClassVariable) asSet.

	self assert: resources ringClassB classPool isEmpty.
]

{ #category : #tests }
RFiClassTest >> testClassVarNames [

	self assert: resources ringClassA classVarNames equals: #('SomeClassVariable').
	self assert: resources ringClassB classVarNames isEmpty
]

{ #category : #tests }
RFiClassTest >> testClassVariableNamed [

	self deny: (resources ringClassA classVariableNamed: 'SomeClassVariable') isNil.

]

{ #category : #tests }
RFiClassTest >> testCompiledMethodAt [
		
	self assert: (resources ringClassA compiledMethodAt: #sum) isNotNil.
	self assert: (resources ringClassA >> #sum) isNotNil.

]

{ #category : #tests }
RFiClassTest >> testCompiledMethodAtIfPresentIfAbsent [

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

{ #category : #tests }
RFiClassTest >> testDefinition [

	self 
		assert: resources ringClassObject definition 
		equals: 'ProtoObject subclass: #Object
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''Kernel''.
Object superclass: nil'.

	self 
		assert: resources ringClassA definition 
		equals: 'Object subclass: #A
	instanceVariableNames: ''a1 a2''
	classVariableNames: ''SomeClassVariable''
	poolDictionaries: ''P''
	category: ''NoCategory'''.
]

{ #category : #tests }
RFiClassTest >> testEnvironment [
		
	| environment |
	environment := resources ringEnvironment.
	
	self assert: (environment classNamed: #A) environment == environment
]

{ #category : #tests }
RFiClassTest >> testGetName [

	self assert: resources ringClassA getName equals: 'A'
]

{ #category : #tests }
RFiClassTest >> testHasAbstractMethods [

	self deny: (resources ringEnvironment classNamed: #True) hasAbstractMethods.
	self assert: (resources ringEnvironment classNamed: #Boolean) hasAbstractMethods.

]

{ #category : #tests }
RFiClassTest >> testIncludesSelector [
		
	self assert: (resources ringClassA includesSelector: #sum).
	self deny: (resources ringClassA includesSelector: #unexistentMethod).

]

{ #category : #tests }
RFiClassTest >> testInstSize [
		
	self assert: resources ringClassA instSize equals: 2.
	self assert: resources ringClassB instSize equals: 3.

]

{ #category : #tests }
RFiClassTest >> testInstVarNames [
		
	self assert: resources ringClassA instVarNames asSet equals: #('a1' 'a2') asSet.
	self assert: resources ringClassB instVarNames asSet equals: #('b1') asSet.

]

{ #category : #tests }
RFiClassTest >> testInstanceVariables [
		
	self assert: resources ringClassA instanceVariables asSet equals: #('a1' 'a2') asSet.
	self assert: resources ringClassB instanceVariables asSet equals: #('b1') asSet.

]

{ #category : #tests }
RFiClassTest >> testIsAnonymous [

	self deny: resources ringClassA isAnonymous
]

{ #category : #tests }
RFiClassTest >> testIsBehavior [
		
	self assert: resources ringClassA isBehavior.
	self assert: resources ringClassB isBehavior.

]

{ #category : #tests }
RFiClassTest >> testIsClass [

	self assert: resources ringClassA isClass
]

{ #category : #tests }
RFiClassTest >> testIsObsolete [

	self deny: resources ringClassA isObsolete.

]

{ #category : #tests }
RFiClassTest >> testIsTrait [

	self deny: resources ringClassA isTrait
]

{ #category : #tests }
RFiClassTest >> testLookupSelector [
		
	self deny: (resources ringClassA lookupSelector: #sum) isNil.
	self assert: (resources ringClassA lookupSelector: #unexistentMethod) isNil.

]

{ #category : #tests }
RFiClassTest >> testMethodDict [

	self 
		assert: resources ringClassA methodDict keys asSet 
		equals: #(#sum #sum42 #sum43) asSet.

]

{ #category : #tests }
RFiClassTest >> testMethods [

	self 
		assert: (resources ringClassA methods collect: #selector) asSet 
		equals: #(#sum #sum42 #sum43) asSet.

]

{ #category : #tests }
RFiClassTest >> testName [

	self assert: resources ringClassA name equals: 'A'
]

{ #category : #tests }
RFiClassTest >> testPackage [
		
	self assert: resources ringClassA package name equals: #X.
]

{ #category : #tests }
RFiClassTest >> testParseTreeFor [
		
	self deny: (resources ringClassA parseTreeFor: #sum) isNil.
	self assert: (resources ringClassA parseTreeFor: #unexistentMethod) isNil.

]

{ #category : #'tests-accessing' }
RFiClassTest >> testRingClassVariableNamed [

	self deny: (resources ringClassA ringClassVariableNamed: 'SomeClassVariable') isNil.
	self deny: (resources ringClassA ringClassVariableNamed: #SomeClassVariable) isNil.

	self 
		assert: (resources ringClassA ringClassVariableNamed: 'SomeClassVariable') definingClass 
		equals: resources ringClassA 
]

{ #category : #'tests-accessing' }
RFiClassTest >> testRingClassVariables [

	self 
		assert: (resources ringClassA ringClassVariables collect: #name) asArray 
		equals: #('SomeClassVariable')

]

{ #category : #'tests-accessing' }
RFiClassTest >> testRingInstanceVariableNamed [

	self deny: (resources ringClassA ringInstanceVariableNamed: 'a1') isNil.
	self deny: (resources ringClassA ringInstanceVariableNamed: #a1) isNil.

	self 
		assert: (resources ringClassA ringInstanceVariableNamed: 'a1') definingClass 
		equals: resources ringClassA 
]

{ #category : #'tests-accessing' }
RFiClassTest >> testRingInstanceVariables [

	self 
		assert: (resources ringClassA ringInstanceVariables collect: #name) asSet 
		equals: #(a1 a2) asSet.

]

{ #category : #tests }
RFiClassTest >> testSelectors [

	self deny: resources ringClassA selectors isEmpty.
	self assert: (resources ringClassA selectors allSatisfy: #isSymbol).

]

{ #category : #tests }
RFiClassTest >> testSelectorsAndMethodsDo [

	| results |
	results := OrderedCollection new.
	
	resources ringClassA selectorsAndMethodsDo: [ :selector :method |
		results add: selector -> method ].

	self assert: results isNotEmpty.
	results do: [ :association |
		self assert: association key equals: association value selector ]
]

{ #category : #tests }
RFiClassTest >> testSharedPoolNames [

	self assert: resources ringClassA sharedPoolNames equals: #(P).
	self assert: resources ringClassB sharedPoolNames isEmpty.
]

{ #category : #tests }
RFiClassTest >> testSharedPools [

	self assert: resources ringClassA sharedPools equals: { resources ringClassP }.
	self assert: resources ringClassB sharedPools isEmpty.
]

{ #category : #tests }
RFiClassTest >> testSourceCodeAtIfAbsent [
		
	self assert: (resources ringClassA sourceCodeAt: #unexistentMethod ifAbsent: [ '' ]) equals: ''.
	self 
		assert: (resources ringClassA sourceCodeAt: #sum ifAbsent: [ '' ]) 
		equals: (resources ringClassA >> #sum) sourceCode.

]

{ #category : #tests }
RFiClassTest >> testSubclasses [

	self assert: resources ringClassA subclasses equals: { resources ringClassB }.
	self assert: resources ringClassB subclasses isEmpty.
]

{ #category : #tests }
RFiClassTest >> testSubclassesDo [

	| result |
	result := OrderedCollection new.
	resources ringClassA subclassesDo: [ :aSubclass | result add: aSubclass ].
	
	self assert: result asArray equals: { resources ringClassB }.
]

{ #category : #tests }
RFiClassTest >> testSuperclass [

	self assert: resources ringClassObject superclass isNil.
	self assert: resources ringClassA superclass equals: resources ringClassObject.
	self assert: resources ringClassB superclass equals: resources ringClassA.
]

{ #category : #tests }
RFiClassTest >> testTheMetaClass [

	self assert: resources ringClassA theMetaClass isMeta.

]

{ #category : #tests }
RFiClassTest >> testTheNonMetaClass [
		
	| aClass |
	aClass := resources ringClassA.

	self assert: aClass theNonMetaClass == aClass.

]

{ #category : #tests }
RFiClassTest >> testWhichCategoryIncludesSelector [
		
	self assert: (resources ringClassA whichCategoryIncludesSelector: #sum) equals: #'as yet unclassified'.

]

{ #category : #tests }
RFiClassTest >> testWhichClassIncludesSelector [

	self deny: (resources ringClassA whichClassIncludesSelector: #sum) isNil.
	self assert: (resources ringClassA whichClassIncludesSelector: #unexistentMethod) isNil.
]

{ #category : #tests }
RFiClassTest >> testWhichSelectorAccess [
		
	self assert: (resources ringClassA whichSelectorsAccess: #a1) asSet equals: { #sum } asSet
]

{ #category : #tests }
RFiClassTest >> testWhichSelectorsRead [

	self 
		assert: (resources ringClassB whichSelectorsRead: #b1) asSet 
		equals: #(sum) asSet.
		
	self 
		assert: (resources ringClassB whichSelectorsRead: #a1) asSet 
		equals: #(variableInSuper) asSet.

]

{ #category : #tests }
RFiClassTest >> testWhichSelectorsReferTo [

	self assert: (resources ringClassC whichSelectorsReferTo: #+) asArray equals: #(sumTmp)
]

{ #category : #tests }
RFiClassTest >> testWhichSelectorsStoreInto [

	self 
		assert: (resources ringClassB whichSelectorsStoreInto: #b1) asSet 
		equals: #(initialize resetAll) asSet.
		
	self 
		assert: (resources ringClassB whichSelectorsStoreInto: #a1) asSet 
		equals: #(resetAll) asSet.

]

{ #category : #tests }
RFiClassTest >> testWithAllSubclasses [

	self assert: resources ringClassA withAllSubclasses asArray equals: { resources ringClassB. resources ringClassA }.
]

{ #category : #tests }
RFiClassTest >> testWithAllSuperAndSubclassesDo [

	| result |
	result := OrderedCollection new.
	resources ringClassA withAllSuperAndSubclassesDo: [ :aSubclass | result add: aSubclass ].
	
	self assert: result asArray equals: { resources ringClassObject. resources ringClassA. resources ringClassB }.
]

{ #category : #tests }
RFiClassTest >> testWithAllSuperclasses [

	self 
		assert: resources ringClassB withAllSuperclasses asArray 
		equals: { resources ringClassB. resources ringClassA. resources ringClassObject }.
]
