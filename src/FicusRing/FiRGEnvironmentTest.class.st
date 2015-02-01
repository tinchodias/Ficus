Class {
	#name : #FiRGEnvironmentTest,
	#superclass : #FiRGObjectTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
FiRGEnvironmentTest >> testAllClasses [

	self deny: resources ficusRGEnvironment allClasses isEmpty
]

{ #category : #tests }
FiRGEnvironmentTest >> testAllClassesAndTraits [

	self deny: resources ficusRGEnvironment allClassesAndTraits isEmpty
]

{ #category : #tests }
FiRGEnvironmentTest >> testAllClassesAndTraitsDo [

	| items |
	items := IdentitySet new.

	resources ficusRGEnvironment allClassesAndTraitsDo: [ :each | items add: each ].

	self deny: items isEmpty
]

{ #category : #tests }
FiRGEnvironmentTest >> testAllClassesDo [

	| items |
	items := IdentitySet new.

	resources ficusRGEnvironment allClassesDo: [ :each | items add: each ].

	self deny: items isEmpty
]

{ #category : #tests }
FiRGEnvironmentTest >> testBindingOf [

	self 
		assert: (resources ficusRGEnvironment bindingOf: #A) 
		equals: (#A -> (resources ficusRGEnvironment classNamed: #A)).

	self assert: (resources ficusRGEnvironment bindingOf: #UnexistentClass) isNil.
	self deny: (resources ficusRGEnvironment bindingOf: #Smalltalk) isNil.


]

{ #category : #tests }
FiRGEnvironmentTest >> testClassNamed [

	self assert: (resources ficusRGEnvironment classNamed: #A) name equals: #A 
]

{ #category : #tests }
FiRGEnvironmentTest >> testHasBindingThatBeginsWith [

	self assert: (resources ficusRGEnvironment hasBindingThatBeginsWith: #A).
	self deny: (resources ficusRGEnvironment hasBindingThatBeginsWith: #UnexistentClass).
	self assert: (resources ficusRGEnvironment hasBindingThatBeginsWith: #Smalltal).
]

{ #category : #'tests-not polymorphic' }
FiRGEnvironmentTest >> testKnownGlobalNames [
	"Define well-known globals by default."

	self 
		assert: resources ficusRGEnvironment knownGlobalNames
		equals: #(#Smalltalk #SourceFiles #Transcript #Undeclared #Display #TextConstants #ActiveWorld #ActiveHand #ActiveEvent #Sensor #Processor #SystemOrganization #World)
]

{ #category : #tests }
FiRGEnvironmentTest >> testPackages [

	self assert: resources ficusRGEnvironment packages size equals: 3.

]
