Class {
	#name : #FiRGEnvironmentTest,
	#superclass : #FiRGShotTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiRGEnvironmentTest >> testAllClasses [

	self deny: ringShotResource environmentWithClassesABC allClasses isEmpty
]

{ #category : #tests }
FiRGEnvironmentTest >> testAllClassesAndTraits [

	self deny: ringShotResource environmentWithClassesABC allClassesAndTraits isEmpty
]

{ #category : #tests }
FiRGEnvironmentTest >> testAllClassesAndTraitsDo [

	| items |
	items := IdentitySet new.

	ringShotResource environmentWithClassesABC allClassesAndTraitsDo: [ :each | items add: each ].

	self deny: items isEmpty
]

{ #category : #tests }
FiRGEnvironmentTest >> testBindingOf [

	self 
		assert: (ringShotResource environmentWithClassesABC bindingOf: #A) 
		equals: (#A -> (ringShotResource environmentWithClassesABC classNamed: #A)).

	self assert: (ringShotResource environmentWithClassesABC bindingOf: #UnexistentClass) isNil

]

{ #category : #tests }
FiRGEnvironmentTest >> testClassNamed [

	self assert: (ringShotResource environmentWithClassesABC classNamed: #A) name equals: #A 
]

{ #category : #tests }
FiRGEnvironmentTest >> testHasBindingThatBeginsWith [

	self assert: (ringShotResource environmentWithClassesABC hasBindingThatBeginsWith: #A).
	self deny: (ringShotResource environmentWithClassesABC hasBindingThatBeginsWith: #UnexistentClass).
]
