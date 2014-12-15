Class {
	#name : #FiRGClassTest,
	#superclass : #FiRGBehaviorTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiRGClassTest >> testAllInstVarNames [

	self assert: resources classA allInstVarNames asSet equals: #('a1' 'a2') asSet.
	self assert: resources classB allInstVarNames asSet equals: #('a1' 'a2' 'b1') asSet
]

{ #category : #tests }
FiRGClassTest >> testAllSelectors [

	self 
		assert: resources classB allSelectors
		equals: (resources classA selectors, resources classB selectors) asSet

]

{ #category : #tests }
FiRGClassTest >> testAllSubclasses [

	self assert: resources classA allSubclasses asArray equals: { resources classB }.
]

{ #category : #tests }
FiRGClassTest >> testAllSubclassesDo [

	| result |
	result := OrderedCollection new.
	resources classA allSubclassesDo: [ :aSubclass | result add: aSubclass ].
	
	self assert: result asArray equals: { resources classB }.
]

{ #category : #tests }
FiRGClassTest >> testAllSuperclasses [

	self assert: resources classB allSuperclasses asArray equals: { resources classA }.
]

{ #category : #tests }
FiRGClassTest >> testAllSuperclassesDo [

	| result |
	result := OrderedCollection new.
	resources classB allSuperclassesDo: [ :aSuperclass | result add: aSuperclass ].
	
	self assert: result asArray equals: { resources classA }.
]

{ #category : #tests }
FiRGClassTest >> testBindingOf [

	| classB |
	classB := resources environmentWithClassesABC classNamed: #B.

	"for an undeclared"
	self assert: (classB bindingOf: #UnexistentClass) isNil.

	"for a global"	
	self deny: (classB bindingOf: #A) isNil.
	self assert: (classB bindingOf: #A) equals: (resources environmentWithClassesABC bindingOf: #A).

	"for a class variable"
	self deny: (classB bindingOf: #BConstants) isNil.
"	self assert: (classB bindingOf: #BConstants) equals: (ringShotResource environmentWithClassesABC bindingOf: #A)."

	self flag: #todo. "Functionality missing: SHAREDPOOLS"


]

{ #category : #tests }
FiRGClassTest >> testCanUnderstand [

	self assert: (resources classA canUnderstand: #sum42).
	self assert: (resources classB canUnderstand: #sum42).

	self deny: (resources classA canUnderstand: #defaultClass).
	self assert: (resources classB canUnderstand: #defaultClass).

]

{ #category : #'tests-polymorphism' }
FiRGClassTest >> testClassPool [

	self assert: resources classA classPool isEmpty.
	self deny: resources classB classPool isEmpty.
]

{ #category : #tests }
FiRGClassTest >> testClassVarNames [

	self assert: resources classA classVarNames isEmpty.
	self assert: resources classB classVarNames asArray equals: #('BConstants')
]

{ #category : #tests }
FiRGClassTest >> testCompiledMethodAt [
		
	self assert: (resources classA compiledMethodAt: #sum) isNotNil.
	self assert: (resources classA >> #sum) isNotNil.

]

{ #category : #tests }
FiRGClassTest >> testCompiledMethodAtIfPresentIfAbsent [

	| presentOrNil |
	presentOrNil := nil.
		
	resources classA 
		compiledMethodAt: #sum
		ifPresent: [ :method | presentOrNil := true ]
		ifAbsent: [ presentOrNil := false ].

	self assert: presentOrNil.

	
	presentOrNil := nil.
		
	resources classA 
		compiledMethodAt: #unexistentMethod
		ifPresent: [ :method | presentOrNil := true ]
		ifAbsent: [ presentOrNil := false ].

	self deny: presentOrNil.
]

{ #category : #tests }
FiRGClassTest >> testEnvironment [
		
	| environment |
	environment := resources environmentWithClassesABC.
	
	self assert: (environment classNamed: #A) environment == environment
]

{ #category : #tests }
FiRGClassTest >> testIncludesSelector [
		
	self assert: (resources classA includesSelector: #sum).
	self deny: (resources classA includesSelector: #unexistentMethod).

]

{ #category : #tests }
FiRGClassTest >> testInstSize [
		
	self assert: resources classA instSize equals: 2.
	self assert: resources classB instSize equals: 3.

]

{ #category : #tests }
FiRGClassTest >> testInstVarNames [
		
	self assert: resources classA instVarNames asSet equals: #('a1' 'a2') asSet.
	self assert: resources classB instVarNames asSet equals: #('b1') asSet.

]

{ #category : #tests }
FiRGClassTest >> testInstanceVariables [
		
	self assert: resources classA instanceVariables asSet equals: #('a1' 'a2') asSet.
	self assert: resources classB instanceVariables asSet equals: #('b1') asSet.

]

{ #category : #tests }
FiRGClassTest >> testIsBehavior [
		
	self assert: resources classA isBehavior.
	self assert: resources classB isBehavior.

]

{ #category : #tests }
FiRGClassTest >> testIsObsolete [

	self deny: resources classA isObsolete.

]

{ #category : #tests }
FiRGClassTest >> testLookupSelector [
		
	self deny: (resources classA lookupSelector: #sum) isNil.
	self assert: (resources classA lookupSelector: #unexistentMethod) isNil.

]

{ #category : #tests }
FiRGClassTest >> testMethods [

	| methodsWithoutExtensions methodsWithExtensions |
	methodsWithoutExtensions := resources classA methods.
	methodsWithExtensions := (resources environmentWithClassesABCAndExtensionMethod classNamed: #A) methods.

	self assert: (methodsWithoutExtensions collect: #selector) asSet equals: #(#sum #sum42) asSet.
	self assert: (methodsWithExtensions collect: #selector) asSet equals: #(#sum #sum42 #sum43) asSet.

]

{ #category : #tests }
FiRGClassTest >> testParseTreeFor [
		
	self deny: (resources classA parseTreeFor: #sum) isNil.
	self assert: (resources classA parseTreeFor: #unexistentMethod) isNil.

]

{ #category : #tests }
FiRGClassTest >> testSelectors [

	self deny: resources classA selectors isEmpty.
	self assert: (resources classA selectors allSatisfy: #isSymbol).

]

{ #category : #tests }
FiRGClassTest >> testSelectorsAndMethodsDo [

	| results |
	results := OrderedCollection new.
	
	resources classA selectorsAndMethodsDo: [ :selector :method |
		results add: selector -> method ].

	self assert: results isNotEmpty.
	results do: [ :association |
		self assert: association key equals: association value selector ]
]

{ #category : #tests }
FiRGClassTest >> testSharedPoolNames [

	self assert: resources classA sharedPoolNames isEmpty.
]

{ #category : #tests }
FiRGClassTest >> testSourceCodeAtIfAbsent [
		
	self assert: (resources classA sourceCodeAt: #unexistentMethod ifAbsent: [ '' ]) equals: ''.
	self 
		assert: (resources classA sourceCodeAt: #sum ifAbsent: [ '' ]) 
		equals: (resources classA >> #sum) sourceCode.

]

{ #category : #tests }
FiRGClassTest >> testSubclasses [

	self assert: resources classA subclasses equals: { resources classB }.
	self assert: resources classB subclasses isEmpty.
]

{ #category : #tests }
FiRGClassTest >> testSubclassesDo [

	| result |
	result := OrderedCollection new.
	resources classA subclassesDo: [ :aSubclass | result add: aSubclass ].
	
	self assert: result asArray equals: { resources classB }.
]

{ #category : #tests }
FiRGClassTest >> testSuperclass [

	self assert: resources classA superclass isNil.
	self assert: resources classB superclass name equals: #A.
]

{ #category : #'tests-polymorphism' }
FiRGClassTest >> testTheMetaClass [

	self assert: resources classA theMetaClass isMeta.

]

{ #category : #tests }
FiRGClassTest >> testTheNonMetaClass [
		
	| aClass |
	aClass := resources classA.

	self assert: aClass theNonMetaClass == aClass.

]

{ #category : #tests }
FiRGClassTest >> testWhichCategoryIncludesSelector [
		
	self assert: (resources classA whichCategoryIncludesSelector: #sum) equals: #autogenerated.

]

{ #category : #tests }
FiRGClassTest >> testWhichClassIncludesSelector [

	self deny: (resources classA whichClassIncludesSelector: #sum) isNil.
	self assert: (resources classA whichClassIncludesSelector: #unexistentMethod) isNil.
]

{ #category : #tests }
FiRGClassTest >> testWhichSelectorAccess [
		
	self assert: (resources classA whichSelectorsAccess: #a1) asSet equals: { #sum } asSet
]

{ #category : #tests }
FiRGClassTest >> testWithAllSubclasses [

	self assert: resources classA withAllSubclasses asArray equals: { resources classB. resources classA }.
]

{ #category : #tests }
FiRGClassTest >> testWithAllSuperAndSubclassesDo [

	| result |
	result := OrderedCollection new.
	resources classA withAllSuperAndSubclassesDo: [ :aSubclass | result add: aSubclass ].
	
	self assert: result asArray equals: { resources classA. resources classB }.
]

{ #category : #'tests-polymorphism' }
FiRGClassTest >> testWithAllSuperclasses [

	self 
		assert: resources classB withAllSuperclasses asArray 
		equals: { resources classB. resources classA }.
]
