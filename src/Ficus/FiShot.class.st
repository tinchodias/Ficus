"
A FiShot is xxxxxxxxx.

I reference some objects indirectly: I hold a name that should be resolved by a store.
"
Class {
	#name : #FiShot,
	#superclass : #Object,
	#instVars : [
		'tag'
	],
	#category : #'Ficus-Model-Core'
}

{ #category : #'instance creation' }
FiShot class >> newFromStepsAndValues: aCollection [ 
	
	^ self basicNew
		initializeFromStepsAndValues: aCollection;
		yourself
]

{ #category : #comparing }
FiShot >> = another [
	
	self == another ifTrue: [ ^ true ].
	self class = another class ifFalse: [ ^ false ].
	self stepCount = another stepCount ifFalse: [ ^ false ].
	
	self 
		stepsAndValuesDo: [ :step :value | 
			another 
				shotAt: step 
				ifPresent: [ :otherValue | value = otherValue ifFalse: [ ^ false ] ]
				ifAbsent: [ ^ false ] ].
		
	^ true	

]

{ #category : #edits }
FiShot >> at: aSlotName edit: aBlockClosure [ 
	
	^ FiAcceptSlot
		slotName: aSlotName
		edit: (aBlockClosure value: (self shotAt: aSlotName))
]

{ #category : #edits }
FiShot >> at: step equal: value [

	^ FiAcceptSlot 
		slotName: step
		edit: (FiEqual value: value)
]

{ #category : #accessing }
FiShot >> defaultStep [
	"Answer a default value, a kind of suggestion to use it as step."
	
	^ self printString asSymbol
]

{ #category : #differencing }
FiShot >> differenceFrom: other [

	| internalEdits |	
	self == other ifTrue: [ ^ self noEdit ].
	self class == other class ifFalse: [ self shouldBeImplemented ].

	internalEdits := Set new.
	
	other stepsAndValuesDo: [ :step :otherValue | 
		| value edit |
		value := self shotAt: step.
		edit := value differenceFrom: otherValue.
		
		edit isNoEdit ifFalse: [
			internalEdits add: (FiAcceptSlot slotName: step edit: edit) ] ].

	^ internalEdits
		ifEmpty: [ self noEdit ]
		ifNotEmpty: [ internalEdits size = 1
			ifTrue: [ internalEdits anyOne ]
			ifFalse: [ self edits: internalEdits ] ]
]

{ #category : #edits }
FiShot >> edits: aCollectionOfEdits [
	
	^ FiCompositeEdit withAll: aCollectionOfEdits
]

{ #category : #effects }
FiShot >> effectOf: anEdit [ 

	^ anEdit effectOn: self
]

{ #category : #effects }
FiShot >> effectOfAcceptSlot: anAcceptSlot [

	^ anAcceptSlot effectUpdate: (self instVarNamed: anAcceptSlot slotName)
]

{ #category : #enumerating }
FiShot >> ficusDeepCollect: aBlock [

	| copy |
	self flag: #fix. "FIX"	

	copy := self copy.

	copy class instanceVariableNamesDo: [ :name |
		copy 
			instVarNamed: name 
			put: ((copy instVarNamed: name) ficusDeepCollect: aBlock) ].

	^ aBlock value: copy
]

{ #category : #enumerating }
FiShot >> ficusDeepDo: aBlock [

	self stepsAndValuesDo: [ :step :value |
		value ficusDeepDo: aBlock ].

	^ aBlock value: self
]

{ #category : #enumerating }
FiShot >> ficusDeepDo: aBlock basePath: aPath [

	self stepsAndValuesDo: [ :step :value |
		value ficusDeepDo: aBlock basePath: (aPath / step) ].

	^ aBlock 
		value: self 
		value: aPath
]

{ #category : #testing }
FiShot >> hasTag [

	^ self tag isNotNil
]

{ #category : #comparing }
FiShot >> hash [
	
	| hash |
	hash := self class hash.
	
	self 
		stepsAndValuesDo: [ :step :value | 
			hash := hash bitXor: value hash ].
		
	^ hash
]

{ #category : #initialization }
FiShot >> initializeFromStepsAndValues: aDictionary [

	self initialize.
	
	aDictionary 
		keysAndValuesDo: [ :slotName :value |
			self instVarNamed: slotName put: value ]
]

{ #category : #testing }
FiShot >> isProxy [
	
	^ false
]

{ #category : #testing }
FiShot >> isPruned [

	self stepsAndValuesDo: [ :step :value |
		(value isShot not or: [ value isProxy ])
			ifFalse: [ ^ false ] ].
		
	^ true
]

{ #category : #testing }
FiShot >> isShot [
	
	^ true
]

{ #category : #copying }
FiShot >> postCopy [
	"In the current state of this prototype, copy is used for performing a modification, so it's a common need to clean the tag."

	tag := nil
]

{ #category : #printing }
FiShot >> printOn: aStream [

	super printOn: aStream.

	self tag ifNil: [ ^ self ].

	aStream 
		space;
		nextPut: $[.

	self tag printOn: aStream.

	aStream 
		nextPut: $];
		space.
]

{ #category : #comparing }
FiShot >> proxyEquals: otherObject [
	
	otherObject isShot ifFalse: [ ^ false ].

	tag ifNotNil: [ tag = otherObject tag ifTrue: [ ^ true ] ].
	
	^ self = otherObject
]

{ #category : #pruning }
FiShot >> pruned [

	^ self tag 
		ifNotNil: [ self taggedPruned ]
		ifNil: [ self untaggedPruned ]
	
]

{ #category : #results }
FiShot >> resultOfAcceptSlot: anAcceptSlot [ 

	^ self copy
		instVarNamed: anAcceptSlot slotName
		put: ((self instVarNamed: anAcceptSlot slotName) resultOf: anAcceptSlot edit);
		yourself

]

{ #category : #results }
FiShot >> resultOfCompositeEdit: aCompositeEdit [ 

	^ aCompositeEdit subEdits 
		inject: self
		into: [ :copy :edit | copy resultOf: edit ]
]

{ #category : #accessing }
FiShot >> shotAt: selector [ 

	^ self perform: selector
]

{ #category : #accessing }
FiShot >> shotAt: step ifPresent: presentBlock ifAbsent: absentBlock [

	step isSymbol ifFalse: [ ^ absentBlock value ].

	^ (self respondsTo: step)
		ifTrue: [ presentBlock cull: (self perform: step) ]
		ifFalse: absentBlock
]

{ #category : #accessing }
FiShot >> stepCount [
	
	^ self class allInstVarNames size - 1 "discount #tag"
]

{ #category : #accessing }
FiShot >> steps [

	| result |
	result := Set new.

	self stepsAndValuesDo: [ :step :value |
		result add: step ].

	^ result
]

{ #category : #enumerating }
FiShot >> stepsAndValues [

	| result |
	result := Set new.

	self stepsAndValuesDo: [ :step :value |
		result add: step -> value ].

	^ result
]

{ #category : #enumerating }
FiShot >> stepsAndValuesDo: aBlockClosure [ 

	^ self class instanceVariableNamesDo: [ :name |
		(name ~= #tag) ifTrue: [
			aBlockClosure 
				value: name asSymbol 
				value: (self instVarNamed: name)] ]

]

{ #category : #accessing }
FiShot >> tag [
	
	^ tag
]

{ #category : #accessing }
FiShot >> tag: anObject [ 

	tag := anObject
]

{ #category : #pruning }
FiShot >> taggedPruned [

	^ FiProxy new tag: self tag
]

{ #category : #pruning }
FiShot >> untaggedPruned [

	| copy |
	self flag: #fix. "FIX"	

	copy := self copy.
	copy class instanceVariableNamesDo: [ :name |
		copy 
			instVarNamed: name 
			put: (copy instVarNamed: name) pruned ].
	^ copy
]
