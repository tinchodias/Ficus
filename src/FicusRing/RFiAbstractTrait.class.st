"
I am an abstract superclass between Trait and ClassTrait in RingFicus. I am intended to be polymorphic with normal trait objects in the system.
"
Class {
	#name : #RFiAbstractTrait,
	#superclass : #RFiBehavior,
	#traits : 'TComposingDescription + TTransformationCompatibility',
	#classTraits : 'TComposingDescription classTrait + TTransformationCompatibility classTrait',
	#category : #'FicusRing-Core'
}

{ #category : #polymorphism }
RFiAbstractTrait >> allClassVarNames [
	
	^ #()
]

{ #category : #polymorphism }
RFiAbstractTrait >> allSharedPools [
	
	^ #()
]

{ #category : #polymorphism }
RFiAbstractTrait >> allSlots [
	
	^ #()
]

{ #category : #accessing }
RFiAbstractTrait >> category [
	
	^ self ficusTrait category
]

{ #category : #polymorphism }
RFiAbstractTrait >> ficusTrait [

	^ self subclassResponsibility
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
	
	self flag: #todo. "extension methods normally override local methods"
	
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

{ #category : #polymorphism }
RFiAbstractTrait >> superclass [
	"For compatibility with classes"

	^ nil
]

{ #category : #polymorphism }
RFiAbstractTrait >> traitCompositionString [

	^ self ficusTrait traitComposition
]

{ #category : #polymorphism }
RFiAbstractTrait >> transformations [
	
	^{ self }
]
