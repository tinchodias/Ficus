Class {
	#name : #FiRGClassTest,
	#superclass : #FiRGShotTest,
	#category : #FicusRing
}

{ #category : #tests }
FiRGClassTest >> testAllInstVarNames [

	self assert: pshotResource classA allInstVarNames asSet equals: #('a1' 'a2') asSet.
	self assert: pshotResource classB allInstVarNames asSet equals: #('a1' 'a2' 'b1' 'b2') asSet
]

{ #category : #tests }
FiRGClassTest >> testCompiledMethodAt [
		
	self assert: (pshotResource classA compiledMethodAt: #sum) isNotNil.
	self assert: (pshotResource classA >> #sum) isNotNil.

]

{ #category : #tests }
FiRGClassTest >> testCompiledMethodAtIfPresentIfAbsent [

	| presentOrNil |
	presentOrNil := nil.
		
	pshotResource classA 
		compiledMethodAt: #sum
		ifPresent: [ :method | presentOrNil := true ]
		ifAbsent: [ presentOrNil := false ].

	self assert: presentOrNil.

	
	presentOrNil := nil.
		
	pshotResource classA 
		compiledMethodAt: #unexistentMethod
		ifPresent: [ :method | presentOrNil := true ]
		ifAbsent: [ presentOrNil := false ].

	self deny: presentOrNil.
]

{ #category : #tests }
FiRGClassTest >> testEnvironment [
		
	| environment |
	environment := pshotResource environmentWithClassesAB.
	
	self assert: (environment classNamed: #A) environment == environment
]

{ #category : #tests }
FiRGClassTest >> testInstVarNames [
		
	self assert: pshotResource classA instVarNames asSet equals: #('a1' 'a2') asSet.
	self assert: pshotResource classB instVarNames asSet equals: #('b1' 'b2') asSet.

]

{ #category : #tests }
FiRGClassTest >> testIsBehavior [
		
	self assert: pshotResource classA isBehavior.
	self assert: pshotResource classB isBehavior.

]

{ #category : #tests }
FiRGClassTest >> testLookupSelector [
		
	self deny: (pshotResource classA lookupSelector: #sum) isNil.
	self assert: (pshotResource classA lookupSelector: #unexistentMethod) isNil.

]

{ #category : #tests }
FiRGClassTest >> testMethods [

	self assert: pshotResource classA methods size equals: 2.
	self assert: pshotResource classB methods size equals: 1.

]

{ #category : #tests }
FiRGClassTest >> testSuperclass [

	self assert: pshotResource classA superclass isNil.
	self assert: pshotResource classB superclass name equals: #A.
]

{ #category : #tests }
FiRGClassTest >> testTheNonMetaClass [
		
	| aClass |
	aClass := pshotResource classA.

	self assert: aClass theNonMetaClass == aClass.

]
