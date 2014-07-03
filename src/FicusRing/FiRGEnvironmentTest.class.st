Class {
	#name : #FiRGEnvironmentTest,
	#superclass : #FiRGShotTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiRGEnvironmentTest >> testAllClasses [

	self assert: ringShotResource environmentWithClassesAB allClasses size equals: 2
]

{ #category : #tests }
FiRGEnvironmentTest >> testAllClassesAndTraits [

	self assert: ringShotResource environmentWithClassesAB allClassesAndTraits size equals: 2
]

{ #category : #tests }
FiRGEnvironmentTest >> testAllClassesAndTraitsDo [

	| items |
	items := IdentitySet new.

	ringShotResource environmentWithClassesAB allClassesAndTraitsDo: [ :each | items add: each ].

	self assert: items size equals: 2
]

{ #category : #tests }
FiRGEnvironmentTest >> testClassNamed [

	self assert: (ringShotResource environmentWithClassesAB classNamed: #A) name equals: #A 
]
