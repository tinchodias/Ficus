Class {
	#name : #FiRGClassTest,
	#superclass : #FiRGShotTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiRGClassTest >> testAllInstVarNames [

	self assert: ringShotResource classA allInstVarNames asSet equals: #('a1' 'a2') asSet.
	self assert: ringShotResource classB allInstVarNames asSet equals: #('a1' 'a2' 'b1') asSet
]

{ #category : #tests }
FiRGClassTest >> testAllSubclassesDo [

	| result |
	result := OrderedCollection new.
	ringShotResource classA allSubclassesDo: [ :aSubclass | result add: aSubclass ].
	
	self assert: result asArray equals: { ringShotResource classB }.
]

{ #category : #tests }
FiRGClassTest >> testAllSuperclassesDo [

	| result |
	result := OrderedCollection new.
	ringShotResource classB allSuperclassesDo: [ :aSuperclass | result add: aSuperclass ].
	
	self assert: result asArray equals: { ringShotResource classA }.
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
FiRGClassTest >> testInstVarNames [
		
	self assert: ringShotResource classA instVarNames asSet equals: #('a1' 'a2') asSet.
	self assert: ringShotResource classB instVarNames asSet equals: #('b1') asSet.

]

{ #category : #tests }
FiRGClassTest >> testIsBehavior [
		
	self assert: ringShotResource classA isBehavior.
	self assert: ringShotResource classB isBehavior.

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

{ #category : #tests }
FiRGClassTest >> testTheNonMetaClass [
		
	| aClass |
	aClass := ringShotResource classA.

	self assert: aClass theNonMetaClass == aClass.

]

{ #category : #tests }
FiRGClassTest >> testWithAllSuperAndSubclassesDo [

	| result |
	result := OrderedCollection new.
	ringShotResource classA withAllSuperAndSubclassesDo: [ :aSubclass | result add: aSubclass ].
	
	self assert: result asArray equals: { ringShotResource classA. ringShotResource classB }.
]
