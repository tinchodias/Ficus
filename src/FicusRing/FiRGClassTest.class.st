Class {
	#name : #FiRGClassTest,
	#superclass : #FiRGBehaviorTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiRGClassTest >> testAllInstVarNames [

	self assert: ringObjectResource classA allInstVarNames asSet equals: #('a1' 'a2') asSet.
	self assert: ringObjectResource classB allInstVarNames asSet equals: #('a1' 'a2' 'b1') asSet
]

{ #category : #tests }
FiRGClassTest >> testAllSelectors [

	self 
		assert: ringObjectResource classB allSelectors
		equals: (ringObjectResource classA selectors, ringObjectResource classB selectors) asSet

]

{ #category : #tests }
FiRGClassTest >> testAllSubclasses [

	self assert: ringObjectResource classA allSubclasses asArray equals: { ringObjectResource classB }.
]

{ #category : #tests }
FiRGClassTest >> testAllSubclassesDo [

	| result |
	result := OrderedCollection new.
	ringObjectResource classA allSubclassesDo: [ :aSubclass | result add: aSubclass ].
	
	self assert: result asArray equals: { ringObjectResource classB }.
]

{ #category : #tests }
FiRGClassTest >> testAllSuperclasses [

	self assert: ringObjectResource classB allSuperclasses asArray equals: { ringObjectResource classA }.
]

{ #category : #tests }
FiRGClassTest >> testAllSuperclassesDo [

	| result |
	result := OrderedCollection new.
	ringObjectResource classB allSuperclassesDo: [ :aSuperclass | result add: aSuperclass ].
	
	self assert: result asArray equals: { ringObjectResource classA }.
]

{ #category : #tests }
FiRGClassTest >> testBindingOf [

	| classB |
	classB := ringObjectResource environmentWithClassesABC classNamed: #B.

	"for an undeclared"
	self assert: (classB bindingOf: #UnexistentClass) isNil.

	"for a global"	
	self deny: (classB bindingOf: #A) isNil.
	self assert: (classB bindingOf: #A) equals: (ringObjectResource environmentWithClassesABC bindingOf: #A).

	"for a class variable"
	self deny: (classB bindingOf: #BConstants) isNil.
"	self assert: (classB bindingOf: #BConstants) equals: (ringShotResource environmentWithClassesABC bindingOf: #A)."

	self flag: #todo. "Functionality missing: SHAREDPOOLS"


]

{ #category : #tests }
FiRGClassTest >> testCanUnderstand [

	self assert: (ringObjectResource classA canUnderstand: #sum42).
	self assert: (ringObjectResource classB canUnderstand: #sum42).

	self deny: (ringObjectResource classA canUnderstand: #defaultClass).
	self assert: (ringObjectResource classB canUnderstand: #defaultClass).

]

{ #category : #'tests-polymorphism' }
FiRGClassTest >> testClassPool [

	self assert: ringObjectResource classA classPool isEmpty.
	self deny: ringObjectResource classB classPool isEmpty.
]

{ #category : #tests }
FiRGClassTest >> testClassVarNames [

	self assert: ringObjectResource classA classVarNames isEmpty.
	self assert: ringObjectResource classB classVarNames asArray equals: #('BConstants')
]

{ #category : #tests }
FiRGClassTest >> testCompiledMethodAt [
		
	self assert: (ringObjectResource classA compiledMethodAt: #sum) isNotNil.
	self assert: (ringObjectResource classA >> #sum) isNotNil.

]

{ #category : #tests }
FiRGClassTest >> testCompiledMethodAtIfPresentIfAbsent [

	| presentOrNil |
	presentOrNil := nil.
		
	ringObjectResource classA 
		compiledMethodAt: #sum
		ifPresent: [ :method | presentOrNil := true ]
		ifAbsent: [ presentOrNil := false ].

	self assert: presentOrNil.

	
	presentOrNil := nil.
		
	ringObjectResource classA 
		compiledMethodAt: #unexistentMethod
		ifPresent: [ :method | presentOrNil := true ]
		ifAbsent: [ presentOrNil := false ].

	self deny: presentOrNil.
]

{ #category : #tests }
FiRGClassTest >> testEnvironment [
		
	| environment |
	environment := ringObjectResource environmentWithClassesABC.
	
	self assert: (environment classNamed: #A) environment == environment
]

{ #category : #tests }
FiRGClassTest >> testIncludesSelector [
		
	self assert: (ringObjectResource classA includesSelector: #sum).
	self deny: (ringObjectResource classA includesSelector: #unexistentMethod).

]

{ #category : #tests }
FiRGClassTest >> testInstSize [
		
	self assert: ringObjectResource classA instSize equals: 2.
	self assert: ringObjectResource classB instSize equals: 3.

]

{ #category : #tests }
FiRGClassTest >> testInstVarNames [
		
	self assert: ringObjectResource classA instVarNames asSet equals: #('a1' 'a2') asSet.
	self assert: ringObjectResource classB instVarNames asSet equals: #('b1') asSet.

]

{ #category : #tests }
FiRGClassTest >> testInstanceVariables [
		
	self assert: ringObjectResource classA instanceVariables asSet equals: #('a1' 'a2') asSet.
	self assert: ringObjectResource classB instanceVariables asSet equals: #('b1') asSet.

]

{ #category : #tests }
FiRGClassTest >> testIsBehavior [
		
	self assert: ringObjectResource classA isBehavior.
	self assert: ringObjectResource classB isBehavior.

]

{ #category : #tests }
FiRGClassTest >> testIsObsolete [

	self deny: ringObjectResource classA isObsolete.

]

{ #category : #tests }
FiRGClassTest >> testLookupSelector [
		
	self deny: (ringObjectResource classA lookupSelector: #sum) isNil.
	self assert: (ringObjectResource classA lookupSelector: #unexistentMethod) isNil.

]

{ #category : #tests }
FiRGClassTest >> testMethods [

	| methodsWithoutExtensions methodsWithExtensions |
	methodsWithoutExtensions := ringObjectResource classA methods.
	methodsWithExtensions := (ringObjectResource environmentWithClassesABCAndExtensionMethod classNamed: #A) methods.

	self assert: (methodsWithoutExtensions collect: #selector) equals: #(#sum #sum42) asSet.
	self assert: (methodsWithExtensions collect: #selector) equals: #(#sum #sum42 #sum43) asSet.

]

{ #category : #tests }
FiRGClassTest >> testParseTreeFor [
		
	self deny: (ringObjectResource classA parseTreeFor: #sum) isNil.
	self assert: (ringObjectResource classA parseTreeFor: #unexistentMethod) isNil.

]

{ #category : #tests }
FiRGClassTest >> testSelectors [

	self deny: ringObjectResource classA selectors isEmpty.
	self assert: (ringObjectResource classA selectors allSatisfy: #isSymbol).

]

{ #category : #tests }
FiRGClassTest >> testSelectorsAndMethodsDo [

	| results |
	results := OrderedCollection new.
	
	ringObjectResource classA selectorsAndMethodsDo: [ :selector :method |
		results add: selector -> method ].

	self assert: results isNotEmpty.
	results do: [ :association |
		self assert: association key equals: association value selector ]
]

{ #category : #tests }
FiRGClassTest >> testSharedPoolNames [

	self assert: ringObjectResource classA sharedPoolNames isEmpty.
]

{ #category : #tests }
FiRGClassTest >> testSourceCodeAtIfAbsent [
		
	self assert: (ringObjectResource classA sourceCodeAt: #unexistentMethod ifAbsent: [ '' ]) equals: ''.
	self 
		assert: (ringObjectResource classA sourceCodeAt: #sum ifAbsent: [ '' ]) 
		equals: (ringObjectResource classA >> #sum) sourceCode.

]

{ #category : #tests }
FiRGClassTest >> testSubclasses [

	self assert: ringObjectResource classA subclasses equals: { ringObjectResource classB }.
	self assert: ringObjectResource classB subclasses isEmpty.
]

{ #category : #tests }
FiRGClassTest >> testSubclassesDo [

	| result |
	result := OrderedCollection new.
	ringObjectResource classA subclassesDo: [ :aSubclass | result add: aSubclass ].
	
	self assert: result asArray equals: { ringObjectResource classB }.
]

{ #category : #tests }
FiRGClassTest >> testSuperclass [

	self assert: ringObjectResource classA superclass isNil.
	self assert: ringObjectResource classB superclass name equals: #A.
]

{ #category : #'tests-polymorphism' }
FiRGClassTest >> testTheMetaClass [

	self assert: ringObjectResource classA theMetaClass isMeta.

]

{ #category : #tests }
FiRGClassTest >> testTheNonMetaClass [
		
	| aClass |
	aClass := ringObjectResource classA.

	self assert: aClass theNonMetaClass == aClass.

]

{ #category : #tests }
FiRGClassTest >> testWhichCategoryIncludesSelector [
		
	self assert: (ringObjectResource classA whichCategoryIncludesSelector: #sum) equals: #autogenerated.

]

{ #category : #tests }
FiRGClassTest >> testWhichClassIncludesSelector [

	self deny: (ringObjectResource classA whichClassIncludesSelector: #sum) isNil.
	self assert: (ringObjectResource classA whichClassIncludesSelector: #unexistentMethod) isNil.
]

{ #category : #tests }
FiRGClassTest >> testWhichSelectorAccess [
		
	self assert: (ringObjectResource classA whichSelectorsAccess: #a1) asSet equals: { #sum } asSet
]

{ #category : #tests }
FiRGClassTest >> testWithAllSubclasses [

	self assert: ringObjectResource classA withAllSubclasses asArray equals: { ringObjectResource classB. ringObjectResource classA }.
]

{ #category : #tests }
FiRGClassTest >> testWithAllSuperAndSubclassesDo [

	| result |
	result := OrderedCollection new.
	ringObjectResource classA withAllSuperAndSubclassesDo: [ :aSubclass | result add: aSubclass ].
	
	self assert: result asArray equals: { ringObjectResource classA. ringObjectResource classB }.
]

{ #category : #'tests-polymorphism' }
FiRGClassTest >> testWithAllSuperclasses [

	self 
		assert: ringObjectResource classB withAllSuperclasses asArray 
		equals: { ringObjectResource classB. ringObjectResource classA }.
]
