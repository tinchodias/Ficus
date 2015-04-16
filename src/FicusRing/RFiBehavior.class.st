"
I am polymorphic with Behavior/ClassDescription.
"
Class {
	#name : #RFiBehavior,
	#superclass : #RFiObject,
	#traits : 'TClassDescription + (TBehavior - {#addSelector:withMethod:notifying:. #addSelectorSilently:withMethod:. #allSharedPools. #applyChangesOfNewTraitCompositionReplacing:. #compile:notifying:. #instVarNames. #isMeta. #notifyUsersOfChangedSelectors:. #obsolete. #subclassesDo:})',
	#classTraits : 'TClassDescription classTrait + TBehavior classTrait',
	#instVars : [
		'cachedMethods',
		'cachedInstanceVariables'
	],
	#category : #'FicusRing-Core'
}

{ #category : #ambiguous }
RFiBehavior >> allSlots [
	
	^ self allInstVarNames collect: #asSlot
]

{ #category : #'*FicusRing' }
RFiBehavior >> allUnsentMessages [
	"Answer an array of all the messages defined by the receiver that are not sent anywhere in the system."

	^ self systemNavigation allUnsentMessagesIn: self selectors
]

{ #category : #hacks }
RFiBehavior >> basicLocalSelectors [
	
	self flag: #fix. "It is not considering Traits"
	
	^ self selectors
]

{ #category : #polymorphism }
RFiBehavior >> compiledMethodAt: selector [ 
	"Answer the compiled method associated with the argument, selector (a 
	Symbol), a message selector in the receiver's method dictionary. If the 
	selector is not in the dictionary, create an error notification."

	^ self methods detect: [ :aMethod | aMethod selector = selector ]
]

{ #category : #polymorphism }
RFiBehavior >> compiledMethodAt: selector ifAbsent: aBlock [

	^ self 
		compiledMethodAt: selector
		ifPresent: [ :method | method ]
		ifAbsent: aBlock
]

{ #category : #polymorphism }
RFiBehavior >> compiledMethodAt: selector ifPresent: anotherBlock ifAbsent: aBlock [
	"Answer the compiled method associated with the argument, selector (a Symbol), a message selector in the receiver's method dictionary. If the selector is not in the dictionary, return the value of aBlock"

	^ self methods 
		detect: [ :aMethod | aMethod selector = selector ]
		ifFound: [ :aMethod | anotherBlock cull: aMethod ]
		ifNone: aBlock
]

{ #category : #polymorphism }
RFiBehavior >> includesSelector: aSymbol [ 
	"Answer whether the message whose selector is the argument is in the 
	method dictionary of the receiver's class."

	^ self
		compiledMethodAt: aSymbol
		ifPresent: [ :method | true ]
		ifAbsent: [ false ].
]

{ #category : #initialization }
RFiBehavior >> initialize [
	super initialize.

]

{ #category : #testing }
RFiBehavior >> instSize [
	"Answer the number of named instance variables
	(as opposed to indexed variables) of the receiver."
	
	^ self allInstVarNames size
]

{ #category : #polymorphism }
RFiBehavior >> isBehavior [

	^ true
]

{ #category : #testing }
RFiBehavior >> isObsolete [

	^ false
]

{ #category : #'testing class hierarchy' }
RFiBehavior >> kindOfSubclass [
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
RFiBehavior >> methodDict [
	
	^ self methods 
		inject: Dictionary new
		into: [ :dictionary :method | 
			dictionary 
				at: method selector 
				put: method;
				yourself ]
]

{ #category : #'accessing method dictionary' }
RFiBehavior >> methodDict: aDictionary [

	^ self shouldNotImplement 
]

{ #category : #polymorphism }
RFiBehavior >> methods [
	
	^ cachedMethods ifNil: [ 
		cachedMethods := Array streamContents: [ :stream |
			stream 
				nextPutAll: (self environment extensionMethodsFor: self); 
				nextPutAll: self localMethods 
			] ]
]

{ #category : #polymorphism }
RFiBehavior >> package [

	^ self environment packageOfClass: self theNonMetaClass
]

{ #category : #printing }
RFiBehavior >> printOn: aStream [

	super printOn: aStream.

	aStream 
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]

{ #category : #accessing }
RFiBehavior >> ringInstanceVariableNamed: aString [

	^ self ringInstanceVariables detect: [ :each | each name = aString ]
]

{ #category : #accessing }
RFiBehavior >> ringInstanceVariables [ 

	^ cachedInstanceVariables ifNil: [
		cachedInstanceVariables := self instVarNames collect: [ :each |
			RFiInstanceVariable definingClass: self name: each ] ]
]

{ #category : #private }
RFiBehavior >> ringMethodFor: ficusMethod [
	"Not API"

	^ RFiMethod
		methodClass: self
		ficusMethod: ficusMethod
]

{ #category : #polymorphism }
RFiBehavior >> selectors [

	^ self methods collect: #selector
]

{ #category : #polymorphism }
RFiBehavior >> selectorsAndMethodsDo: selectorAndMethodBlock [
	"Evaluate selectorAndMethodBlock with two arguments for each selector/method pair in my method dictionary."

	^ self methods do: [ :each | 
		selectorAndMethodBlock value: each selector value: each ]
]

{ #category : #'*FicusRing' }
RFiBehavior >> systemNavigation [

	^ SystemNavigation new 
		environment: self environment;
		yourself
]

{ #category : #'testing method dictionary' }
RFiBehavior >> thoroughHasSelectorReferringTo: literal special: specialFlag byte: specialByte [
	"Just ignore some arguments. Standard implementation is already thorough :)"

	self notYetImplemented 
]

{ #category : #'testing method dictionary' }
RFiBehavior >> thoroughWhichSelectorsReferTo: literal special: specialFlag byte: specialByte [
	"Just ignore some arguments. Standard implementation is already thorough :)"
	
	^ self whichSelectorsReferTo: literal
]

{ #category : #traits }
RFiBehavior >> traitComposition [

	self flag: #todo. 

	^ TraitComposition new
]

{ #category : #organization }
RFiBehavior >> whichCategoryIncludesSelector: aSelector [ 
	"Answer the category of the argument, aSelector, in the organization of 
	the receiver, or answer nil if the receiver does not inlcude this selector."

	^ self 
		compiledMethodAt: aSelector
		ifPresent: [ :method | method protocol ]
		ifAbsent: [ nil ]
]

{ #category : #queries }
RFiBehavior >> whichSelectorsAccess: aString [
	
	^ self methods 
		select: [:method | 
			(method selectAllVariables: [:node | 
				node isInstance and: [ (node isRead or: [node isWrite]) and: [ node name = aString ]]]) 
				isEmpty not ]
		thenCollect: [:method | method selector ]
]

{ #category : #queries }
RFiBehavior >> whichSelectorsRead: aString [
	
	^ self methods 
		select: [:method | 
			(method selectAllVariables: [:node | 
				node isInstance and: [ node isRead and: [ node name = aString ]]]) 
				isEmpty not ]
		thenCollect: [:method | method selector ]
]

{ #category : #'testing method dictionary' }
RFiBehavior >> whichSelectorsReferTo: literal [ 
	"Answer a Set of selectors whose methods access the argument as a
literal."

	^ self methods 
		select: [ :each | each refersToLiteral: literal ]
		thenCollect: [ :each | each selector ]
]

{ #category : #'testing method dictionary' }
RFiBehavior >> whichSelectorsReferTo: literal special: specialFlag byte: specialByte [
	"Just ignore some arguments"
	
	^ self whichSelectorsReferTo: literal
]

{ #category : #'testing method dictionary' }
RFiBehavior >> whichSelectorsStoreInto: instVarName [ 
	"Answer a Set of selectors whose methods access the argument, 
	instVarName, as a named instance variable."

	^ self methods 
		select: [:method | 
			(method selectAllVariables: [:node | 
				node isInstance and: [ node isWrite and: [ node name = instVarName ]]]) 
				isEmpty not ]
		thenCollect: [:method | method selector ]
]
