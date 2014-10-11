"
I am polymorphic with Behavior/ClassDescription.
"
Class {
	#name : #FiRGBehavior,
	#superclass : #FiRGShot,
	#traits : 'TClassDescription + (TBehavior - {#addSelector:withMethod:notifying:. #addSelectorSilently:withMethod:. #allSharedPools. #applyChangesOfNewTraitCompositionReplacing:. #compile:notifying:. #instVarNames. #isMeta. #notifyUsersOfChangedSelectors:. #obsolete. #subclassesDo:})',
	#classTraits : 'TClassDescription classTrait + TBehavior classTrait',
	#category : #'FicusRing-Core'
}

{ #category : #hacks }
FiRGBehavior >> basicLocalSelectors [
	
	self flag: #fix. "It is not considering Traits"
	
	^ self selectors
]

{ #category : #initialization }
FiRGBehavior >> initialize [
	super initialize.

]

{ #category : #testing }
FiRGBehavior >> instSize [
	"Answer the number of named instance variables
	(as opposed to indexed variables) of the receiver."
	
	^ self allInstVarNames size
]

{ #category : #'as yet unclassified' }
FiRGBehavior >> isObsolete [

	^ false
]

{ #category : #printing }
FiRGBehavior >> printOn: arg1 [ 
	super printOn: arg1 
]

{ #category : #private }
FiRGBehavior >> ringMethodFor: aMethodShot [

	^ FiRGMethod new 
		ringMethodClass: self;
		shot: aMethodShot;
		yourself
]

{ #category : #polymorphism }
FiRGBehavior >> selectors [

	^ self methods collect: #selector
]

{ #category : #polymorphism }
FiRGBehavior >> selectorsAndMethodsDo: selectorAndMethodBlock [
	"Evaluate selectorAndMethodBlock with two arguments for each selector/method pair in my method dictionary."

	^ self methods do: [ :each | 
		selectorAndMethodBlock value: each selector value: each ]
]

{ #category : #organization }
FiRGBehavior >> whichCategoryIncludesSelector: aSelector [ 
	"Answer the category of the argument, aSelector, in the organization of 
	the receiver, or answer nil if the receiver does not inlcude this selector."

	^ self 
		compiledMethodAt: aSelector
		ifPresent: [ :method | method protocol ]
		ifAbsent: [ nil ]
]
