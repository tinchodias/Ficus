"
I am an abstract superclass between Trait and ClassTrait in RingFicus. I am intended to be polymorphic with normal trait objects in the system.
"
Class {
	#name : #RFiAbstractTrait,
	#superclass : #RFiObject,
	#instVars : [
		'cachedMethods'
	],
	#category : #'FicusRing-Core'
}

{ #category : #composition }
RFiAbstractTrait >> + aTraitExpression [
	^aTraitExpression addCompositionOnLeft: self asTraitComposition.
]

{ #category : #polymorphism }
RFiAbstractTrait >> >> aSelector [
	
	^ self methods detect: [ :each | each selector = aSelector ]
]

{ #category : #'as yet unclassified' }
RFiAbstractTrait >> addCompositionOnLeft: aTraitComposition [
	^aTraitComposition add: self.
]

{ #category : #polymorphism }
RFiAbstractTrait >> allClassVarNames [
	
	^ #()
]

{ #category : #polymorphism }
RFiAbstractTrait >> allSelectors [

	^ self methods collect: #selector
]

{ #category : #polymorphism }
RFiAbstractTrait >> allSharedPools [
	
	^ #()
]

{ #category : #polymorphism }
RFiAbstractTrait >> allSlots [
	
	^ #()
]

{ #category : #polymorphism }
RFiAbstractTrait >> asTraitComposition [
	
	^ TraitComposition with: self
]

{ #category : #accessing }
RFiAbstractTrait >> category [
	
	^ self ficusTrait category
]

{ #category : #polymorphism }
RFiAbstractTrait >> collectMethodsFor: aSelector into: methodDescription [
	
	methodDescription addLocatedMethod: (self compiledMethodAt: aSelector)
]

{ #category : #polymorphism }
RFiAbstractTrait >> compiledMethodAt: selector [ 
	
	^ self methods detect: [ :aMethod | aMethod selector = selector ]
]

{ #category : #polymorphism }
RFiAbstractTrait >> ficusTrait [

	self subclassResponsibility
]

{ #category : #polymorphism }
RFiAbstractTrait >> includesLocalSelector: aString [ 
	
	^ self localSelectors includes: aString
]

{ #category : #methods }
RFiAbstractTrait >> localMethods [
	
	^ self ficusTrait methods collect: [ :aMethodShot | 
		self ringMethodFor: aMethodShot ]
]

{ #category : #accessing }
RFiAbstractTrait >> localSelectors [
	
	^ self localMethods collect: #selector
]

{ #category : #methods }
RFiAbstractTrait >> methods [
	
	^ cachedMethods ifNil: [ | methods |
		methods := Dictionary new.
		self traitProvidedMethods
			do: [ :each | methods at: each selector put: (self ringMethodFor: each) ].
		(self environment extensionMethodsFor: self)
			do: [ :each | methods at: each selector put: each ].
		self localMethods
			do: [ :each | methods at: each selector put: each ].
		cachedMethods := methods values ]
]

{ #category : #private }
RFiAbstractTrait >> ringMethodFor: ficusMethod [
	"Not API"

	^ RFiMethod
		methodClass: self
		ficusMethod: ficusMethod
]

{ #category : #polymorphism }
RFiAbstractTrait >> trait [
	
	^ self
]

{ #category : #polymorphism }
RFiAbstractTrait >> traitComposition [

	| traitCompositionAST |
	traitCompositionAST := RBParser parseExpression: self ficusTrait traitComposition.
	^ (traitCompositionAST acceptVisitor: (RFiTraitCompositionAssembler on: self environment)) asTraitComposition
]

{ #category : #polymorphism }
RFiAbstractTrait >> traitCompositionString [

	^ self ficusTrait traitComposition.
]

{ #category : #polymorphism }
RFiAbstractTrait >> traitProvidedMethods [
	| providedMethods |
	providedMethods := Set new.
	self traitComposition transformations do: [ :t |
		t allSelectors do: [ :selector | | methodDescription |
			methodDescription := TraitMethodDescription selector: selector.
			t collectMethodsFor: selector into: methodDescription.
			methodDescription methodsDo: [ :m |
				((providedMethods anySatisfy: [ :provided | provided selector = m selector ]) or: [ self includesLocalSelector: m selector])
					ifFalse: [ providedMethods add: m ].
			].
		].
	].
	^providedMethods
]

{ #category : #polymorphism }
RFiAbstractTrait >> transformations [
	
	^{ self }
]
