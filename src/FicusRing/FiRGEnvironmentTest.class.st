Class {
	#name : #FiRGEnvironmentTest,
	#superclass : #FiRGObjectTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiRGEnvironmentTest >> testAllClasses [

	self deny: ringObjectResource environmentWithClassesABC allClasses isEmpty
]

{ #category : #tests }
FiRGEnvironmentTest >> testAllClassesAndTraits [

	self deny: ringObjectResource environmentWithClassesABC allClassesAndTraits isEmpty
]

{ #category : #tests }
FiRGEnvironmentTest >> testAllClassesAndTraitsDo [

	| items |
	items := IdentitySet new.

	ringObjectResource environmentWithClassesABC allClassesAndTraitsDo: [ :each | items add: each ].

	self deny: items isEmpty
]

{ #category : #tests }
FiRGEnvironmentTest >> testAllClassesDo [

	| items |
	items := IdentitySet new.

	ringObjectResource environmentWithClassesABC allClassesDo: [ :each | items add: each ].

	self deny: items isEmpty
]

{ #category : #tests }
FiRGEnvironmentTest >> testBindingOf [

	self 
		assert: (ringObjectResource environmentWithClassesABC bindingOf: #A) 
		equals: (#A -> (ringObjectResource environmentWithClassesABC classNamed: #A)).

	self assert: (ringObjectResource environmentWithClassesABC bindingOf: #UnexistentClass) isNil

]

{ #category : #tests }
FiRGEnvironmentTest >> testClassNamed [

	self assert: (ringObjectResource environmentWithClassesABC classNamed: #A) name equals: #A 
]

{ #category : #tests }
FiRGEnvironmentTest >> testHasBindingThatBeginsWith [

	self assert: (ringObjectResource environmentWithClassesABC hasBindingThatBeginsWith: #A).
	self deny: (ringObjectResource environmentWithClassesABC hasBindingThatBeginsWith: #UnexistentClass).
]
