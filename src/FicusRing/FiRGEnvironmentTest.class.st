Class {
	#name : #FiRGEnvironmentTest,
	#superclass : #FiRGObjectTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiRGEnvironmentTest >> testAllClasses [

	self deny: resources environmentWithAll allClasses isEmpty
]

{ #category : #tests }
FiRGEnvironmentTest >> testAllClassesAndTraits [

	self deny: resources environmentWithAll allClassesAndTraits isEmpty
]

{ #category : #tests }
FiRGEnvironmentTest >> testAllClassesAndTraitsDo [

	| items |
	items := IdentitySet new.

	resources environmentWithAll allClassesAndTraitsDo: [ :each | items add: each ].

	self deny: items isEmpty
]

{ #category : #tests }
FiRGEnvironmentTest >> testAllClassesDo [

	| items |
	items := IdentitySet new.

	resources environmentWithAll allClassesDo: [ :each | items add: each ].

	self deny: items isEmpty
]

{ #category : #tests }
FiRGEnvironmentTest >> testBindingOf [

	self 
		assert: (resources environmentWithAll bindingOf: #A) 
		equals: (#A -> (resources environmentWithAll classNamed: #A)).

	self assert: (resources environmentWithAll bindingOf: #UnexistentClass) isNil.
	self deny: (resources environmentWithAll bindingOf: #Smalltalk) isNil.


]

{ #category : #tests }
FiRGEnvironmentTest >> testClassNamed [

	self assert: (resources environmentWithAll classNamed: #A) name equals: #A 
]

{ #category : #tests }
FiRGEnvironmentTest >> testHasBindingThatBeginsWith [

	self assert: (resources environmentWithAll hasBindingThatBeginsWith: #A).
	self deny: (resources environmentWithAll hasBindingThatBeginsWith: #UnexistentClass).
	self assert: (resources environmentWithAll hasBindingThatBeginsWith: #Smalltal).
]

{ #category : #'tests-not polymorphic' }
FiRGEnvironmentTest >> testKnownGlobalNames [
	"Define well-known globals by default."

	self 
		assert: resources environmentWithAll knownGlobalNames
		equals: #(#Smalltalk #SourceFiles #Transcript #Undeclared #Display #TextConstants #ActiveWorld #ActiveHand #ActiveEvent #Sensor #Processor #SystemOrganization #World)
]
