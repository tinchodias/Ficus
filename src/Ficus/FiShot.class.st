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
	
	self stepsAndValuesDo: [ :step :value | 
		another 
			shotAt: step 
			ifPresent: [ :otherValue | value = otherValue ifFalse: [ ^ false ] ]
			ifAbsent: [ ^ false ] ].
		
	^ true	

]

{ #category : #accessing }
FiShot >> defaultStep [
	"Answer a default value, a kind of suggestion to use it as step."
	
	^ self subclassResponsibility
]

{ #category : #differencing }
FiShot >> differenceFrom: other [

	^ self subclassResponsibility 
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
FiShot >> effectOfCompositeEdit: aCompositeEdit [ 

	^ FiCompositeEffect new
		edit: aCompositeEdit;
		subEffects: (aCompositeEdit subEdits collect: [ :anEdit | anEdit effectOn: self ]);
		yourself
]

{ #category : #enumerating }
FiShot >> ficusDeepCollect: aBlock [

	| newStepsAndValues |
	newStepsAndValues := Dictionary new.
	
	self stepsAndValuesDo: [ :step :value | 
		newStepsAndValues 
			at: (step ficusDeepCollect: aBlock)
			put: (value ficusDeepCollect: aBlock) ].

	^ aBlock value: (self species newFromStepsAndValues: newStepsAndValues)
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
	
	self stepsAndValuesDo: [ :step :value | 
		hash := (hash bitXor: step hash) bitXor: value hash ].
		
	^ hash
]

{ #category : #initialization }
FiShot >> initializeFromStepsAndValues: aDictionary [

	self subclassResponsibility 
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
FiShot >> resultOfCompositeEdit: aCompositeEdit [ 

	^ aCompositeEdit subEdits 
		inject: self
		into: [ :copy :edit | copy resultOf: edit ]
]

{ #category : #accessing }
FiShot >> shotAt: step [

	^ self 
		shotAt: step 
		ifPresent: [ :shot | shot ]
		ifAbsent: [ NotFound signal ]
]

{ #category : #accessing }
FiShot >> shotAt: step ifPresent: presentBlock ifAbsent: absentBlock [

	^ self subclassResponsibility 
]

{ #category : #accessing }
FiShot >> stepCount [
	
	^ self steps size
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

	^ self subclassResponsibility 
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

	| newStepsAndValues |
	newStepsAndValues := Dictionary new.
	
	self stepsAndValuesDo: [ :step :value | 
		newStepsAndValues 
			at: step pruned
			put: value pruned ].

	^ self species newFromStepsAndValues: newStepsAndValues
]

{ #category : #accessing }
FiShot >> values [
	
	| answer |
	answer := Set new.

	self valuesDo: [ :each | answer add: each ].

	^ answer 
]

{ #category : #accessing }
FiShot >> valuesDo: elementBlock [
	"Evaluates the block on each value of this object"
	
	^ self stepsAndValuesDo: [ :step :value | elementBlock value: value ]
]
