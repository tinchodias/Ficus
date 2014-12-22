"
I am polymorphic with Behavior/ClassDescription.
"
Class {
	#name : #FiRGBehavior,
	#superclass : #FiRGObject,
	#traits : 'TClassDescription + (TBehavior - {#addSelector:withMethod:notifying:. #addSelectorSilently:withMethod:. #allSharedPools. #applyChangesOfNewTraitCompositionReplacing:. #compile:notifying:. #instVarNames. #isMeta. #notifyUsersOfChangedSelectors:. #obsolete. #subclassesDo:})',
	#classTraits : 'TClassDescription classTrait + TBehavior classTrait',
	#category : #'FicusRing-Core'
}

{ #category : #ambiguous }
FiRGBehavior >> allSlots [
	
	^ self allInstVarNames collect: #asSlot
]

{ #category : #hacks }
FiRGBehavior >> basicLocalSelectors [
	
	self flag: #fix. "It is not considering Traits"
	
	^ self selectors
]

{ #category : #polymorphism }
FiRGBehavior >> includesSelector: aSymbol [ 
	"Answer whether the message whose selector is the argument is in the 
	method dictionary of the receiver's class."

	^ self
		compiledMethodAt: aSymbol
		ifPresent: [ :method | true ]
		ifAbsent: [ false ].
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

{ #category : #polymorphism }
FiRGBehavior >> isBehavior [

	^ true
]

{ #category : #'as yet unclassified' }
FiRGBehavior >> isObsolete [

	^ false
]

{ #category : #'testing class hierarchy' }
FiRGBehavior >> kindOfSubclass [
	"Answer a String that is the keyword that describes the receiver's kind 
	of subclass, either a regular subclass, a variableSubclass, a  
	variableByteSubclass, a variableWordSubclass, or a weakSubclass."

	self flag: #todo. "FIX"
	^ ' subclass: '
	
"	self isWeak
		ifTrue: [^ ' weakSubclass: '].
	^ self isVariable
		ifTrue: [self isBits
				ifTrue: [self isBytes
						ifTrue: [ ' variableByteSubclass: ']
						ifFalse: [ ' variableWordSubclass: ']]
				ifFalse: [ ' variableSubclass: ']]
		ifFalse: [ ' subclass: ']"
]

{ #category : #'accessing method dictionary' }
FiRGBehavior >> methodDict [
	
	^ self methods 
		inject: Dictionary new
		into: [ :dictionary :method | 
			dictionary 
				at: method selector 
				put: method;
				yourself ]
]

{ #category : #printing }
FiRGBehavior >> printOn: aStream [

	super printOn: aStream.

	aStream 
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]

{ #category : #private }
FiRGBehavior >> ringMethodFor: aMethodShot [

	^ FiRGMethod new 
		methodClass: self;
		methodShot: aMethodShot;
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

{ #category : #traits }
FiRGBehavior >> traitComposition [

	self flag: #todo. 

	^ TraitComposition new
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

{ #category : #queries }
FiRGBehavior >> whichSelectorsRead: aString [
	
	^ self methods 
		select: [:method | 
			(method selectAllVariables: [:node | 
				node isInstance and: [ node isRead and: [ node name = aString ]]]) 
				isEmpty not ]
		thenCollect: [:method | method selector ]
]

{ #category : #'testing method dictionary' }
FiRGBehavior >> whichSelectorsReferTo: literal [ 
	"Answer a Set of selectors whose methods access the argument as a
literal."

	^ self methods 
		select: [ :each | each refersToLiteral: literal ]
		thenCollect: [ :each | each selector ]
]
