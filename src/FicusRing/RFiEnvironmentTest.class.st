Class {
	#name : #RFiEnvironmentTest,
	#superclass : #RFiObjectTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
RFiEnvironmentTest >> testAllClasses [

	self 
		assert: (resources ringEnvironment allClasses collect: #name) asSet
		equals: #(#Object #Boolean #Class #SmallInteger #A #True #B #False #C #P #BlockClosure) asSet
]

{ #category : #tests }
RFiEnvironmentTest >> testAllClassesAndTraits [

	self deny: resources ringEnvironment allClassesAndTraits isEmpty
]

{ #category : #tests }
RFiEnvironmentTest >> testAllClassesAndTraitsDo [

	| items |
	items := IdentitySet new.

	resources ringEnvironment allClassesAndTraitsDo: [ :each | items add: each ].

	self deny: items isEmpty
]

{ #category : #tests }
RFiEnvironmentTest >> testAllClassesDo [

	| items |
	items := IdentitySet new.

	resources ringEnvironment allClassesDo: [ :each | items add: each ].

	self deny: items isEmpty
]

{ #category : #tests }
RFiEnvironmentTest >> testBindingOf [

	self 
		assert: (resources ringEnvironment bindingOf: #A) 
		equals: (#A -> (resources ringEnvironment classNamed: #A)).

	self assert: (resources ringEnvironment bindingOf: #UnexistentClass) isNil.
	self deny: (resources ringEnvironment bindingOf: #Smalltalk) isNil.


]

{ #category : #tests }
RFiEnvironmentTest >> testClassNamed [

	self assert: (resources ringEnvironment classNamed: #A) name equals: #A 
]

{ #category : #tests }
RFiEnvironmentTest >> testHasBindingThatBeginsWith [

	self assert: (resources ringEnvironment hasBindingThatBeginsWith: #A).
	self deny: (resources ringEnvironment hasBindingThatBeginsWith: #UnexistentClass).
	self assert: (resources ringEnvironment hasBindingThatBeginsWith: #Smalltal).
]

{ #category : #'tests-not polymorphic' }
RFiEnvironmentTest >> testKnownGlobalNames [
	"Define well-known globals by default."

	self 
		assert: resources ringEnvironment knownGlobalNames
		equals: #(#Smalltalk #SourceFiles #Transcript #Undeclared #Display #ActiveWorld #ActiveHand #ActiveEvent #Sensor #Processor #SystemOrganization #World)
]

{ #category : #tests }
RFiEnvironmentTest >> testPackages [

	self assert: resources ringEnvironment packages size equals: 3.

]
