Class {
	#name : #RFiEnvironmentTest,
	#superclass : #RFiObjectTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
RFiEnvironmentTest >> testAllClasses [

	self deny: resources ficusRGEnvironment allClasses isEmpty
]

{ #category : #tests }
RFiEnvironmentTest >> testAllClassesAndTraits [

	self deny: resources ficusRGEnvironment allClassesAndTraits isEmpty
]

{ #category : #tests }
RFiEnvironmentTest >> testAllClassesAndTraitsDo [

	| items |
	items := IdentitySet new.

	resources ficusRGEnvironment allClassesAndTraitsDo: [ :each | items add: each ].

	self deny: items isEmpty
]

{ #category : #tests }
RFiEnvironmentTest >> testAllClassesDo [

	| items |
	items := IdentitySet new.

	resources ficusRGEnvironment allClassesDo: [ :each | items add: each ].

	self deny: items isEmpty
]

{ #category : #tests }
RFiEnvironmentTest >> testBindingOf [

	self 
		assert: (resources ficusRGEnvironment bindingOf: #A) 
		equals: (#A -> (resources ficusRGEnvironment classNamed: #A)).

	self assert: (resources ficusRGEnvironment bindingOf: #UnexistentClass) isNil.
	self deny: (resources ficusRGEnvironment bindingOf: #Smalltalk) isNil.


]

{ #category : #tests }
RFiEnvironmentTest >> testClassNamed [

	self assert: (resources ficusRGEnvironment classNamed: #A) name equals: #A 
]

{ #category : #tests }
RFiEnvironmentTest >> testHasBindingThatBeginsWith [

	self assert: (resources ficusRGEnvironment hasBindingThatBeginsWith: #A).
	self deny: (resources ficusRGEnvironment hasBindingThatBeginsWith: #UnexistentClass).
	self assert: (resources ficusRGEnvironment hasBindingThatBeginsWith: #Smalltal).
]

{ #category : #'tests-not polymorphic' }
RFiEnvironmentTest >> testKnownGlobalNames [
	"Define well-known globals by default."

	self 
		assert: resources ficusRGEnvironment knownGlobalNames
		equals: #(#Smalltalk #SourceFiles #Transcript #Undeclared #Display #ActiveWorld #ActiveHand #ActiveEvent #Sensor #Processor #SystemOrganization #World)
]

{ #category : #tests }
RFiEnvironmentTest >> testPackages [

	self assert: resources ficusRGEnvironment packages size equals: 3.

]
