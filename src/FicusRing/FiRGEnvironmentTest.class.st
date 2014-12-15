Class {
	#name : #FiRGEnvironmentTest,
	#superclass : #FiRGObjectTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiRGEnvironmentTest >> testAllClasses [

	self deny: resources environmentWithClassesABC allClasses isEmpty
]

{ #category : #tests }
FiRGEnvironmentTest >> testAllClassesAndTraits [

	self deny: resources environmentWithClassesABC allClassesAndTraits isEmpty
]

{ #category : #tests }
FiRGEnvironmentTest >> testAllClassesAndTraitsDo [

	| items |
	items := IdentitySet new.

	resources environmentWithClassesABC allClassesAndTraitsDo: [ :each | items add: each ].

	self deny: items isEmpty
]

{ #category : #tests }
FiRGEnvironmentTest >> testAllClassesDo [

	| items |
	items := IdentitySet new.

	resources environmentWithClassesABC allClassesDo: [ :each | items add: each ].

	self deny: items isEmpty
]

{ #category : #tests }
FiRGEnvironmentTest >> testBindingOf [

	self 
		assert: (resources environmentWithClassesABC bindingOf: #A) 
		equals: (#A -> (resources environmentWithClassesABC classNamed: #A)).

	self assert: (resources environmentWithClassesABC bindingOf: #UnexistentClass) isNil

]

{ #category : #tests }
FiRGEnvironmentTest >> testClassNamed [

	self assert: (resources environmentWithClassesABC classNamed: #A) name equals: #A 
]

{ #category : #tests }
FiRGEnvironmentTest >> testHasBindingThatBeginsWith [

	self assert: (resources environmentWithClassesABC hasBindingThatBeginsWith: #A).
	self deny: (resources environmentWithClassesABC hasBindingThatBeginsWith: #UnexistentClass).
]
