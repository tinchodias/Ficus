"
I represent an immutable object which must not form cycles with other FiShots. 

A shot has #steps, which are Symbol names which can be used to access the corresponding #values.
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
FiShot class >> builder [
	
	^ FiShotBuilder forClass: self
]

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

{ #category : #differencing }
FiShot >> differenceFrom: other [

	^ self subclassResponsibility 
]

{ #category : #edits }
FiShot >> edits: aCollectionOfEdits [
	
	^ FiCompositeEdit withAll: (FiSet withValues: aCollectionOfEdits)
]

{ #category : #effects }
FiShot >> effectOf: anEdit [ 

	^ anEdit effectOn: self
]

{ #category : #effects }
FiShot >> effectOfCompositeEdit: aCompositeEdit [ 

	^ FiCompositeEffect builder
		edit: aCompositeEdit;
		subEffects: (FiSet withValues: (aCompositeEdit subEdits values collect: [ :anEdit | anEdit effectOn: self ]));
		new
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

{ #category : #converting }
FiShot >> flattened [
	
	^ (Array streamContents: [ :stream |
		self 
			ficusDeepDo: [ :value :path | stream nextPut: path -> value ]
			basePath: FiPath root ])
		reversed

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
FiShot >> isShot [
	
	^ true
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

{ #category : #results }
FiShot >> resultOfCompositeEdit: aCompositeEdit [ 

	^ aCompositeEdit subEdits values
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
