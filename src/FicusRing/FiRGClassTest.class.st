Class {
	#name : #FiRGClassTest,
	#superclass : #FiRGBehaviorTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiRGClassTest >> testAllInstVarNames [

	self assert: ringShotResource classA allInstVarNames asSet equals: #('a1' 'a2') asSet.
	self assert: ringShotResource classB allInstVarNames asSet equals: #('a1' 'a2' 'b1') asSet
]

{ #category : #tests }
FiRGClassTest >> testAllSelectors [

	self 
		assert: ringShotResource classB allSelectors
		equals: (ringShotResource classA selectors, ringShotResource classB selectors) asSet

]

{ #category : #tests }
FiRGClassTest >> testAllSubclasses [

	self assert: ringShotResource classA allSubclasses asArray equals: { ringShotResource classB }.
]

{ #category : #tests }
FiRGClassTest >> testAllSubclassesDo [

	| result |
	result := OrderedCollection new.
	ringShotResource classA allSubclassesDo: [ :aSubclass | result add: aSubclass ].
	
	self assert: result asArray equals: { ringShotResource classB }.
]

{ #category : #tests }
FiRGClassTest >> testAllSuperclasses [

	self assert: ringShotResource classB allSuperclasses asArray equals: { ringShotResource classA }.
]

{ #category : #tests }
FiRGClassTest >> testAllSuperclassesDo [

	| result |
	result := OrderedCollection new.
	ringShotResource classB allSuperclassesDo: [ :aSuperclass | result add: aSuperclass ].
	
	self assert: result asArray equals: { ringShotResource classA }.
]

{ #category : #tests }
FiRGClassTest >> testBindingOf [

	| classB |
	classB := ringShotResource environmentWithClassesABC classNamed: #B.

	"for an undeclared"
	self assert: (classB bindingOf: #UnexistentClass) isNil.

	"for a global"	
	self deny: (classB bindingOf: #A) isNil.
	self assert: (classB bindingOf: #A) equals: (ringShotResource environmentWithClassesABC bindingOf: #A).

	"for a class variable"
	self deny: (classB bindingOf: #BConstants) isNil.
"	self assert: (classB bindingOf: #BConstants) equals: (ringShotResource environmentWithClassesABC bindingOf: #A)."

	self flag: #todo. "Functionality missing: SHAREDPOOLS"


]

{ #category : #tests }
FiRGClassTest >> testCanUnderstand [

	self assert: (ringShotResource classA canUnderstand: #sum42).
	self assert: (ringShotResource classB canUnderstand: #sum42).

	self deny: (ringShotResource classA canUnderstand: #defaultClass).
	self assert: (ringShotResource classB canUnderstand: #defaultClass).

]

{ #category : #'tests-polymorphism' }
FiRGClassTest >> testClassPool [

	self assert: ringShotResource classA classPool isEmpty.
	self deny: ringShotResource classB classPool isEmpty.
]

{ #category : #tests }
FiRGClassTest >> testClassVarNames [

	self assert: ringShotResource classA classVarNames isEmpty.
	self assert: ringShotResource classB classVarNames asArray equals: #('BConstants')
]

{ #category : #tests }
FiRGClassTest >> testCompiledMethodAt [
		
	self assert: (ringShotResource classA compiledMethodAt: #sum) isNotNil.
	self assert: (ringShotResource classA >> #sum) isNotNil.

]

{ #category : #tests }
FiRGClassTest >> testCompiledMethodAtIfPresentIfAbsent [

	| presentOrNil |
	presentOrNil := nil.
		
	ringShotResource classA 
		compiledMethodAt: #sum
		ifPresent: [ :method | presentOrNil := true ]
		ifAbsent: [ presentOrNil := false ].

	self assert: presentOrNil.

	
	presentOrNil := nil.
		
	ringShotResource classA 
		compiledMethodAt: #unexistentMethod
		ifPresent: [ :method | presentOrNil := true ]
		ifAbsent: [ presentOrNil := false ].

	self deny: presentOrNil.
]

{ #category : #tests }
FiRGClassTest >> testEnvironment [
		
	| environment |
	environment := ringShotResource environmentWithClassesABC.
	
	self assert: (environment classNamed: #A) environment == environment
]

{ #category : #tests }
FiRGClassTest >> testIncludesSelector [
		
	self assert: (ringShotResource classA includesSelector: #sum).
	self deny: (ringShotResource classA includesSelector: #unexistentMethod).

]

{ #category : #tests }
FiRGClassTest >> testInstSize [
		
	self assert: ringShotResource classA instSize equals: 2.
	self assert: ringShotResource classB instSize equals: 3.

]

{ #category : #tests }
FiRGClassTest >> testInstVarNames [
		
	self assert: ringShotResource classA instVarNames asSet equals: #('a1' 'a2') asSet.
	self assert: ringShotResource classB instVarNames asSet equals: #('b1') asSet.

]

{ #category : #tests }
FiRGClassTest >> testInstanceVariables [
		
	self assert: ringShotResource classA instanceVariables asSet equals: #('a1' 'a2') asSet.
	self assert: ringShotResource classB instanceVariables asSet equals: #('b1') asSet.

]

{ #category : #tests }
FiRGClassTest >> testIsBehavior [
		
	self assert: ringShotResource classA isBehavior.
	self assert: ringShotResource classB isBehavior.

]

{ #category : #tests }
FiRGClassTest >> testIsObsolete [

	self deny: ringShotResource classA isObsolete.

]

{ #category : #tests }
FiRGClassTest >> testLookupSelector [
		
	self deny: (ringShotResource classA lookupSelector: #sum) isNil.
	self assert: (ringShotResource classA lookupSelector: #unexistentMethod) isNil.

]

{ #category : #tests }
FiRGClassTest >> testMethods [

	self deny: ringShotResource classA methods isEmpty.

]

{ #category : #tests }
FiRGClassTest >> testParseTreeFor [
		
	self deny: (ringShotResource classA parseTreeFor: #sum) isNil.
	self assert: (ringShotResource classA parseTreeFor: #unexistentMethod) isNil.

]

{ #category : #tests }
FiRGClassTest >> testSelectors [

	self deny: ringShotResource classA selectors isEmpty.
	self assert: (ringShotResource classA selectors allSatisfy: #isSymbol).

]

{ #category : #tests }
FiRGClassTest >> testSelectorsAndMethodsDo [

	| results |
	results := OrderedCollection new.
	
	ringShotResource classA selectorsAndMethodsDo: [ :selector :method |
		results add: selector -> method ].

	self assert: results isNotEmpty.
	results do: [ :association |
		self assert: association key equals: association value selector ]
]

{ #category : #tests }
FiRGClassTest >> testSharedPoolNames [

	self assert: ringShotResource classA sharedPoolNames isEmpty.
]

{ #category : #tests }
FiRGClassTest >> testSourceCodeAtIfAbsent [
		
	self assert: (ringShotResource classA sourceCodeAt: #unexistentMethod ifAbsent: [ '' ]) equals: ''.
	self 
		assert: (ringShotResource classA sourceCodeAt: #sum ifAbsent: [ '' ]) 
		equals: (ringShotResource classA >> #sum) sourceCode.

]

{ #category : #tests }
FiRGClassTest >> testSubclasses [

	self assert: ringShotResource classA subclasses equals: { ringShotResource classB }.
	self assert: ringShotResource classB subclasses isEmpty.
]

{ #category : #tests }
FiRGClassTest >> testSubclassesDo [

	| result |
	result := OrderedCollection new.
	ringShotResource classA subclassesDo: [ :aSubclass | result add: aSubclass ].
	
	self assert: result asArray equals: { ringShotResource classB }.
]

{ #category : #tests }
FiRGClassTest >> testSuperclass [

	self assert: ringShotResource classA superclass isNil.
	self assert: ringShotResource classB superclass name equals: #A.
]

{ #category : #'tests-polymorphism' }
FiRGClassTest >> testTheMetaClass [

	self assert: ringShotResource classA theMetaClass isMeta.

]

{ #category : #tests }
FiRGClassTest >> testTheNonMetaClass [
		
	| aClass |
	aClass := ringShotResource classA.

	self assert: aClass theNonMetaClass == aClass.

]

{ #category : #tests }
FiRGClassTest >> testWhichCategoryIncludesSelector [
		
	self assert: (ringShotResource classA whichCategoryIncludesSelector: #sum) equals: #autogenerated.

]

{ #category : #tests }
FiRGClassTest >> testWhichClassIncludesSelector [

	self deny: (ringShotResource classA whichClassIncludesSelector: #sum) isNil.
	self assert: (ringShotResource classA whichClassIncludesSelector: #unexistentMethod) isNil.
]

{ #category : #tests }
FiRGClassTest >> testWhichSelectorAccess [
		
	self assert: (ringShotResource classA whichSelectorsAccess: #a1) asSet equals: { #sum } asSet
]

{ #category : #tests }
FiRGClassTest >> testWithAllSubclasses [

	self assert: ringShotResource classA withAllSubclasses asArray equals: { ringShotResource classB. ringShotResource classA }.
]

{ #category : #tests }
FiRGClassTest >> testWithAllSuperAndSubclassesDo [

	| result |
	result := OrderedCollection new.
	ringShotResource classA withAllSuperAndSubclassesDo: [ :aSubclass | result add: aSubclass ].
	
	self assert: result asArray equals: { ringShotResource classA. ringShotResource classB }.
]

{ #category : #'tests-polymorphism' }
FiRGClassTest >> testWithAllSuperclasses [

	self 
		assert: ringShotResource classB withAllSuperclasses asArray 
		equals: { ringShotResource classB. ringShotResource classA }.
]
